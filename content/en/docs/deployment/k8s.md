---
title: "Kubernetes"
linkTitle: "Kubernetes"
weight: 20
---

This guide explains how to run the deps.cloud infrastructure within a [Kubernetes](https://kubernetes.io/) cluster.

## Prerequisites

1. A working Kubernetes cluster. To follow along with this guide, you should set up [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) on your machine. Minikube provides a great way to test and experiment around with Kubernetes locally.
1. The `kubectl` binary should be installed and in your path on your workstation.

## 1 - Configure a Storage Class

deps.cloud leverages MySQL to store a given graphs dependency information.
MySQL requires a persistent volume to be able to ensure the data is persisted to disk.
In Kubernetes, a [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) can either be manually provisioned by a System Administrator or Dynamically provisioned using a [Storage Class](https://kubernetes.io/docs/concepts/storage/storage-classes/).
To figure out if you need to install a Storage Class, you can use `kubectl` to see which ones have been configured on the cluster already.

```bash
$ kubectl get storageclasses.storage.k8s.io
NAME                 PROVISIONER                    AGE
standard (default)   k8s.io/minikube-hostpath       14d
```

If you're have none, you can configure a `local-storage` class.
This leverages the storage provided by the host that the pod is running on.
It also creates an affinity so that the next time the pod restarts, it will prefer that host over the others.

```bash
$ cat <<EOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF
```

## 2 - Set-up Workspace

Before deploying any workloads, we first need a workspace to deploy into.
The following command creates a Kubernetes [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) 
with the name `depscloud`.

```bash
$ kubectl create ns depscloud
```

Once created, [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/), 
[Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/), and 
[RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) can be used to lock down the system.
All the resources created in this walk through will be deployed to this namespace.

## 3 - Deploy MySQL

If you don't already have a MySQL database available, you can deploy one using one of the many helm charts out there. 
The following deployment was generated from the [bitnami/mysql](https://github.com/bitnami/charts/tree/master/bitnami/mysql).

```bash
$ kubectl apply -n depscloud -f https://depscloud.github.io/deploy/k8s/mysql.yaml
```

This deployment comes with a single primary node and a read only replica node. 

## 4 - Configure deps.cloud

By default, the tracker and indexer do not come configured.
This allows operators to connect it to provide their specific configuration.
To configure these processes, you'll need to create two 
[secrets](https://kubernetes.io/docs/concepts/configuration/secret/) in the `depscloud` namespace.

To configure the tracker, you'll need to provide a `depscloud-tracker` secret.
This secret is used to connect the tracker to the previously provisioned MySQL database. 

```bash
$ cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  namespace: depscloud
  name: depscloud-tracker
stringData:
  STORAGE_DRIVER: mysql
  STORAGE_ADDRESS: user-rw:password@tcp(mysql:3306)/depscloud
  STORAGE_READ_ONLY_ADDRESS: user:password@tcp(mysql:3306)/depscloud
EOF
```

To configure the indexer, you'll need to provide a `depscloud-indexer` secret.
This file tells the indexer how to discovery and clone repositories. 
The following configuration will index the deps.cloud repositories.

```bash
$ cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  namespace: depscloud
  name: depscloud-indexer
stringData:
  config.yaml: |
    accounts:
    - github:
        strategy: HTTP
        organizations:
        - depscloud
EOF
```

You can learn more about how to configure the indexer process on the [integrations](/docs/integrations/) page.

## 4 - Deploy deps.cloud

After the tracker and indexer have been configured, you'll be able to deploy the deps.cloud infrastructure.
This configuration can be found with the other deployment configuration on [GitHub](https://github.com/depscloud/deploy). 

```bash
$ kubectl apply -n depscloud -f https://depscloud.github.io/deploy/k8s/depscloud-system.yaml
```

Once all processes have completed and are healthy, you should be able to interact with the API pretty easily.
To quickly test this, you can port forward to one of the `gateway` pods directly.

```
$ kubectl port-forward -n depscloud svc/depscloud-gateway 8080:80
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

Once the port is forwarded, the following endpoints should be able to be reached.

* [What sources have been indexed?](http://localhost:8080/v1alpha/sources)
* [What modules are produced by this repository?](http://localhost:8080/v1alpha/modules/managed?url=https%3A%2F%2Fgithub.com%2Fdepscloud%2Fextractor.git)
* [What modules do I depend on and what version?](http://localhost:8080/v1alpha/graph/go/dependencies?organization=github.com&module=depscloud%2Fextractor)
* [What modules depend on me and what version?](http://localhost:8080/v1alpha/graph/go/dependents?organization=github.com&module=depscloud%2Fapi)
* [What repositories can produce this module?](http://localhost:8080/v1alpha/modules/source?organization=github.com&module=depscloud%2Fextractor&language=go)
