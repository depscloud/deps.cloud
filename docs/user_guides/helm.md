---
layout: doc
title: User Guides
---

# Helm

This guide explains how to run the deps.cloud infrastructure within a [Kubernetes](https://kubernetes.io/) cluster using the [Helm](https://helm.sh/) package manager.

## Prerequisites

1. A working Kubernetes cluster. To follow along with this guide, you should set up [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) on your machine. Minikube provides a great way to test and experiment around with Kubernetes locally.
1. The `kubectl` binary should be installed and in your path on your workstation.
1. The `helm` binary should be installed and in your path on your workstation.

## 1 - Adding the Helm Repository

In order to leverage the deps.cloud Helm charts, you first need to add the deps.cloud stable repository.

```
$ helm repo add depscloud-stable https://deps-cloud.github.io/charts/stable
"depscloud-stable" has been added to your repositories
```

To use more experimental changes, you can tap our incubator repository instead.

```
$ helm repo add depscloud-incubator https://deps-cloud.github.io/charts/incubator
"depscloud-incubator" has been added to your repositories
```

## 2 - Deploy the deps.cloud Infrastructure

Once the deps.cloud chart repository has been added, you can install the charts as follows.

```
$ helm upgrade -i tracker depscloud-stable/tracker
$ helm upgrade -i extractor depscloud-stable/extractor
$ helm upgrade -i gateway depscloud-stable/gateway
$ helm upgrade -i indexer depscloud-stable/indexer
```

This same set of commands can be used to upgrade the charts.

## 3 - Querying the deps.cloud Infrastructure

Once all processes have completed and are healthy, you should be able to interact with the API pretty easily.
To quickly test this, you can port forward to one of the `gateway` pods directly.

```
$ kubectl port-forward -n depscloud-system gateway-797fd99747-j4wbb 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

Once the port is forwarded, the following endpoints should be able to be reached.

* [What sources have been indexed?](http://localhost:8080/v1alpha/sources)
* [What modules are produced by this repository?](http://localhost:8080/v1alpha/modules/managed?url=https%3A%2F%2Fgithub.com%2Fdeps-cloud%2Fdes.git)
* [What modules do I depend on and what version?](http://localhost:8080/v1alpha/graph/go/dependencies?organization=github.com&module=deps-cloud%2Fdes)
* [What modules depend on me and what version?](http://localhost:8080/v1alpha/graph/go/dependents?organization=github.com&module=deps-cloud%2Fdes)
* [What repositories produce can produce this module?](http://localhost:8080/v1alpha/modules/source?organization=github.com&module=deps-cloud%2Fdes&language=go)

## 4 - Optionally Installments

The following are optional considerations.
You do not need to install them to run the system, but can make managing it easier.

### Ingress

By using an ingress address and controller, you can easily expose the REST API.

```yaml
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: api
spec:
  rules:
  - host: api.deps.cloud
    http:
      paths:
      - path: /
        backend:
          serviceName: gateway
          servicePort: 80
```

### Using helm-operator

The [helm-operator](https://github.com/fluxcd/helm-operator) provided by fluxcd is an extremely powerful resource.
If provides a way to manage Helm releases within a cluster through custom resource definitions.

```yaml
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: indexer
  namespace: prod
spec:
  releaseName: indexer
  chart:
    repository: https://deps-cloud.github.io/charts/stable
    name: indexer
    version: 0.1.2
  values:
    schedule: "@daily"
    config:
      accounts:
        - github:
            strategy: HTTP
            organizations:
              - deps-cloud
```
