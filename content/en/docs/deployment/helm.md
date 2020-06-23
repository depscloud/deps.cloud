---
title: "Helm"
linkTitle: "Helm"
weight: 30
date: 2020-06-20
---

This guide explains how to run the deps.cloud infrastructure within a [Kubernetes](https://kubernetes.io/) cluster using the [Helm](https://helm.sh/) package manager.

## Prerequisites

1. A working Kubernetes cluster. To follow along with this guide, you should set up [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) on your machine. Minikube provides a great way to test and experiment around with Kubernetes locally.
1. The `kubectl` binary should be installed and in your path on your workstation.
1. The `helm` binary should be installed and in your path on your workstation.

## 1 - Adding the Helm Repository

In order to leverage the deps.cloud Helm charts, you first need to add the deps.cloud stable repository.

```
$ helm repo add depscloud https://deps-cloud.github.io/deploy/charts
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
$ kubectl port-forward -n depscloud svc/depscloud-gateway 8080:80
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

Once the port is forwarded, the following endpoints should be able to be reached.

* [What sources have been indexed?](http://localhost:8080/v1alpha/sources)
* [What modules are produced by this repository?](http://localhost:8080/v1alpha/modules/managed?url=https%3A%2F%2Fgithub.com%2Fdeps-cloud%2Fextractor.git)
* [What modules do I depend on and what version?](http://localhost:8080/v1alpha/graph/go/dependencies?organization=github.com&module=deps-cloud%2Fextractor)
* [What modules depend on me and what version?](http://localhost:8080/v1alpha/graph/go/dependents?organization=github.com&module=deps-cloud%2Fapi)
* [What repositories can produce this module?](http://localhost:8080/v1alpha/modules/source?organization=github.com&module=deps-cloud%2Fextractor&language=go)

## 4 - Configuring using values.yaml

A `values.yaml` file can be used to maintain deployment specific configuration.
The content below provides an example of how to configure the indexer to crawl the deps-cloud account.

```yaml
# contents of values.yaml
indexer:
  config:
    accounts:
      - github:
          clone:
            strategy: HTTP
          organizations:
            - deps-cloud

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

## 5 - Optional Installments

The following are optional considerations.
You do not need to install them to run the system, but can make managing it easier.

### Ingress

By using an ingress address and controller, you can easily expose the REST API.

```yaml
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  namespace: depscloud
  name: depscloud
spec:
  rules:
  - host: depscloud.internal.company.net
    http:
      paths:
      - path: /
        backend:
          serviceName: depscloud-gateway
          servicePort: 80
```

### Using helm-operator

The [helm-operator](https://github.com/fluxcd/helm-operator) provided by fluxcd is an extremely powerful resource.
If provides a way to manage Helm releases within a cluster through custom resource definitions.

```yaml
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  namespace: depscloud
  name: depscloud
spec:
  releaseName: depscloud
  chart:
    repository: https://deps-cloud.github.io/deploy/charts
    name: depscloud
  values:
    indexer:
      schedule: "@daily"
      config:
        accounts:
          - github:
              clone:
                strategy: HTTP
              organizations:
                - deps-cloud
```
