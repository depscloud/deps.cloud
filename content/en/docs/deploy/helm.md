---
title: "Helm"
linkTitle: "Helm"
weight: 30
aliases:
- /docs/deployment/helm/
---

This guide explains how to run the deps.cloud infrastructure within a [Kubernetes](https://kubernetes.io/) cluster using the [Helm](https://helm.sh/) package manager.

## Prerequisites

1. A working Kubernetes cluster. To follow along with this guide, you should set up [Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/) on your machine. Minikube provides a great way to test and experiment around with Kubernetes locally.
1. The `kubectl` binary should be installed and in your path on your workstation.
1. The `helm` binary should be installed and in your path on your workstation.

## 1 - Adding the Helm Repository

In order to leverage the deps.cloud Helm charts, you first need to add the deps.cloud stable repository.

```
$ helm repo add depscloud https://depscloud.github.io/deploy/charts
"depscloud" has been added to your repositories

$ helm repo update
```

## 2 - Deploy the deps.cloud Infrastructure

Once the deps.cloud chart repository has been added, you can install the charts as follows.

```
$ kubectl create ns depscloud
namespace/depscloud created

$ helm upgrade -n depscloud -i depscloud depscloud/depscloud
Release "depscloud" does not exist. Installing it now.
NAME: depscloud
LAST DEPLOYED: Sat Jun 20 16:50:57 2020
NAMESPACE: depscloud
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

This same command can be used to upgrade the system in the future.

## 3 - Querying the deps.cloud Infrastructure

Once all processes have completed and are healthy, you should be able to interact with the API pretty easily.
Note that there will be no data in the API until the indexer process has run.
To quickly test this, you can port forward the `depscloud-gateway` service.

```
$ kubectl port-forward -n depscloud svc/depscloud-gateway 8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

Once forwarded, you can test it out by installing our command line tool and setting the `DEPSCLOUD_BASE_URL` environment variable.
To learn more, head on over to our [CLI user guide]({{< ref "/docs/guides/cli.md" >}}).

## 4 - Configuring using values.yaml

A `values.yaml` file can be used to maintain deployment specific configuration.
The content below provides an example of how to configure the indexer to crawl the depscloud account.

```yaml
# contents of values.yaml
indexer:
  config:
    accounts:
      - github:
          clone:
            strategy: HTTP
          organizations:
            - depscloud

tracker:
  storage:
    driver: sqlite|mysql|postgres
    address: ""
    readOnlyAddress: ""
```

Then during install, you can pass in the `values.yaml` file.

```bash
$ helm upgrade -n depscloud -i depscloud depscloud/depscloud -f values.yaml
```

## 5 - Ingress

By using an ingress address and controller, you can easily expose the API.

```yaml
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: "nginx"
    # use cert-manager for TLS
    kubernetes.io/tls-acme: "true"
    cert-manager.io/cluster-issuer: "letsencrypt"
    # ingress-nginx specific annotations
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/backend-protocol: "GRPC"
    nginx.ingress.kubernetes.io/enable-cors: "true"
  hosts:
    - host: depscloud.company.net
      paths:
        - /
  tls:
    - secretName: depscloud-tls
      hosts:
        - depscloud.company.net
```

After adding the ingress configuration block, you'll need to upgrade the deployment.

```bash
$ helm upgrade -i -n depscloud depscloud depscloud/depscloud -f values.yaml
```