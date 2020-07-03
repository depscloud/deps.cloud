---
title: "User-facing gRPC services"
author: Mya Pitzeruse
date: 2020-07-03
---

[gRPC](https://grpc.io/) is a remote procedure call framework used to facilitate inter-process communication.
Originally open sourced by Google, the framework has been adopted my many companies like Square, Netflix, and Cisco.
While many companies have adopted gRPC internally, few have leveraged it closer to the edge.
In this post, we will demonstrate how we set up a public facing gRPC service.

Before getting too far into things, it's important to first understand the benefits and challenges when using gRPC.

#### Benefits to using gRPC

* Generic service definition language
* Code generation support for [12 languages](https://grpc.io/docs/languages/)
* Support for bi-directional streaming APIs, enabling more complex APIs
* Integrated authentication

#### Challenges with gRPC

* Requires [HTTP/2](https://http2.github.io/) all the way through the call stack
  * When connecting through a proxy service like on Cloudflare, connections often degrade to HTTP/1.1
* Browser based user experiences requires support from the ecosystem
  * REST endpoints not available out of box
  * Browser based calls require use of `grpc-web`

Due to potential protocol downgrades, it's important to verify this is a possible solution for your stack.
For example, some load balancer implementations do not support HTTP/2.
You should check with your cloud provider to see if they offer either an HTTP/2 compatible, or a layer 4 load balancer.

If you're connecting through a [Kubernetes ingress](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/),
then you will need to ensure that your ingress controller supports gRPC.
I've found this [table](https://docs.google.com/spreadsheets/d/1DnsHtdHbxjvHmxvlu7VhzWcWgLAn_Mc5L1WlhLDA__k)
to be valuable when evaluating ingress solutions.
It breaks down common features across ingress controllers, popular implementations, and their support.

## Serving REST and gRPC on the same address

Once you've verified that your providers can support HTTP/2 you can start to think about code. 
`api.deps.cloud` not only provides a RESTful interface, but a gRPC one as well.
As a consumer of a service, I find this to be a really convenient feature.
We're able to do this using the [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway) project and some clever
structuring of server handlers.
The Golang snippet below walks you through the general setup.

```go
import (
    "github.com/depscloud/api/v1alpha/tracker"
    "github.com/depscloud/gateway/internal/proxies"

    "github.com/grpc-ecosystem/grpc-gateway/runtime"

    "github.com/rs/cors"
        
    "golang.org/x/net/http2"
    "golang.org/x/net/http2/h2c"

    "google.golang.org/grpc"
)

func main() {
    // set up all servers.
    grpcServer := grpc.NewServer()
    restServer := runtime.NewServeMux()
    httpServer := http.NewServeMux()

    // register all services to both grpc and gateway.
    sourceService := tracker.NewSourceServiceClient(trackerConn)
    tracker.RegisterSourceServiceServer(grpcServer, proxies.NewSourceServiceProxy(sourceService))
    _ = tracker.RegisterSourceServiceHandlerClient(ctx, restServer, sourceService)
    // ...

    // detect and handle grpc requests.
    // this approach does incur a small performance penalty, 
    // but is pretty acceptable for communication happening at the edge. 
    httpServer.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
        if request.ProtoMajor == 2 &&
            strings.HasPrefix(request.Header.Get("Content-Type"), "application/grpc") {
            grpcServer.ServeHTTP(writer, request)
        } else {
            restServer.ServeHTTP(writer, request)
        }
    })
    
    // go's http server only supports secure HTTP/2 out of box.
    // wrap with h2c for plaintext (i.e. if you do TLS termination elsewhere.)
    h2cServer := h2c.NewHandler(httpServer, &http2.Server{})
    
    // wrap with CORS to support cross-origin requests.
    apiServer := cors.Default().Handler(h2cServer)
}
```

That's it!
Working around TLS termination can be a bit tricky.
For a closer look at our implementation, take a look at the [gateway](https://github.com/depscloud/gateway) process.
This typically sits behind a reverse proxy and mediates communication with the backend services. 

## Configuring an ingress controller

Regardless of where you're running, you'll probably need to do some amount of special configuration to enable gRPC.
In Kubernetes, this is often done through the use of annotations.
While each ingress controller uses a different annotation, the practice tends to be the same.
Below, you will find an example configuration for the Kubernetes [nginx-ingress](https://github.com/kubernetes/ingress-nginx).

```yaml
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  namespace: depscloud
  name: depscloud
  annotations:
    # cert-manager
    # Sets up certificates for HTTPS support using different issuers. 
    kubernetes.io/tls-acme: "true"
    cert-manager.io/cluster-issuer: "letsencrypt"
    # ingress controller
    # identify the ingress class to handle this definition,
    # if you should force SSL connections,
    # or if you need to swap protocols (i.e. terminate TLS)
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/backend-protocol: "GRPC"
spec:
  tls:
    - hosts:
        - depscloud.company.net
      secretName: api-certs
  rules:
    - host: depscloud.company.net
      http:
        paths:
        - path: /
          backend:
            serviceName: depscloud-gateway
            servicePort: 80
```

## Connecting a client application

If you force SSL, you want to make sure clients pass along SSL credentials.
When using [LetsEncrypt](https://letsencrypt.org/), you shouldn't need to pass in any certificates.
Simply instantiate empty SSL credentials.

Here's an example using Go.

```go
package main

import (
    "crypto/tls"

    "github.com/depscloud/api/v1alpha/tracker"   
    
    "google.golang.org/grpc"
    "google.golang.org/grpc/credentials"
)

func main() {
    target := "depscloud.company.net:443"
    creds := credentials.NewTLS(&tls.Config{})

    conn, _ := grpc.Dial(target, grpc.WithTransportCredentials(creds))
    defer conn.Close()
    
    dependencyService := tracker.NewDependencyServiceClient(conn)
    
    resp, _ := dependencyService.ListDependents(&tracker.DependencyRequest{
        Language:     "go",
        Organization: "github.com",
        Module:       "depscloud/api",
    })

    for _, dependent := range resp.GetDependents() {
        // ...
    }
}
```

Here's another example using NodeJS.

```js
const grpc = require("@grpc/grpc-js");
const { DependencyService } = require("@depscloud/api/v1alpha/tracker");

async function main() {
    const target = "depscloud.company.net:443";
    const creds = grpc.credentials.createSsl();

    const dependencyService = new DependencyService(target, creds);

    dependencyService.listDependents({
        language: "node",
        organization: "depscloud",
        module: "api",
    }, (err, { dependents }) => {
        // ...
    })
}
```

Because gRPC offers code generation across 12 different languages, supporting new clients is easy.
Simply resolve the protocol buffer definition, supply the plugin to the compiler, and generate!
