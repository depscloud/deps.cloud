---
layout: doc
title: User Guides
---

# Kubernetes

This guide explains how to run the deps.cloud infrastructure within a [Kubernetes](https://kubernetes.io/) cluster.

The configuration files used in this guide can be found in the `examples/k8s` directory of the [deps.cloud](https://github.com/deps-cloud/deps.cloud) repository.

## Prerequisites

1. A working Kubernetes cluster. To follow along with this guide, you should set up [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) on your machine. Minikube provides a great way to test and experiment around with Kubernetes locally.
1. The `kubectl` binary should be installed and in your path on your workstation.

## 1 - Configure a Storage Class

deps.cloud leverages MySQL to store a given graphs dependency information.
MySQL requires a persistent volume to be able to ensure the data is persisted to disk.
In Kubernetes, a [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) can either be manually provisioned by a System Administrator or Dynamically provisioned using a [Storage Class](https://kubernetes.io/docs/concepts/storage/storage-classes/).
To figure out if you need to install a Storage Class, you can use `kubectl` to see which ones have been configured on the cluster already.

```
$ kubectl get storageclasses.storage.k8s.io
NAME                 PROVISIONER                    AGE
standard (default)   k8s.io/minikube-hostpath       14d
```

If you're have none, you can configure a `local-storage` class.
This leverages the storage provided by the host that the pod is running on.
It also creates an affinity so that the next time the pod restarts, it will prefer that host over the others.

```yaml 
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```

To enable the storage class, you can apply the configuration provided by the repository.

```
$ kubectl apply -f local-storage.yaml
```

## 2 - Deploy the deps.cloud Infrastructure

The next step of the process is to deploy the components of the deps.cloud ecosystem.
There are a few different moving parts to this system.
First let's create the namespace that these systems will be running in.

```
$ kubectl apply -f manifests/_.yaml
```

The dependency extraction service (`extractor.yaml`) is responsible for matching and extracting data from files.
It's deployed as a replicated `Deployment` so that it can elastically scale to the needed request load.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: depscloud-system
  name: extractor
  labels:
    app: depscloud
spec:
  replicas: 5
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: extractor
  template:
    metadata:
      labels:
        app: extractor
    spec:
      containers:
      - name: extractor
        image: depscloud/extractor:latest
        imagePullPolicy: Always
        resources:
          limits:
            cpu: 200m
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 100Mi

---
# Headless service for stable DNS entries of members
apiVersion: v1
kind: Service
metadata:
  namespace: depscloud-system
  name: extractor
  labels:
    app: depscloud
spec:
  selector:
    app: extractor
  clusterIP: None
  ports:
  - name: grpc
    port: 8090
    targetPort: 8090
```

This system requires no dependencies and can easily be applied to the cluster.

```
$ kubectl apply -f manifests/extractor.yaml
```

The dependency tracker service (`tracker.yaml`) contains the business logic for inserting and retrieving data from the database (`mysql.yaml`).

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: depscloud-system
  name: tracker
  labels:
    app: depscloud
spec:
  replicas: 3
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: tracker
  template:
    metadata:
      labels:
        app: tracker
    spec:
      initContainers:
      - name: service-precheck
        image: mjpitz/service-precheck:latest
        imagePullPolicy: Always
        args:
        - "mysql"
        - "mysql-read"
      containers:
      - name: dts
        image: depscloud/tracker:latest
        imagePullPolicy: Always
        args:
        - --storage-driver=mysql
        - --storage-address=user:password@tcp(mysql-0.mysql:3306)/depscloud
        - --storage-readonly-address=user:password@tcp(mysql:3306)/depscloud
        resources:
          limits:
            cpu: 200m
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 100Mi

---
# Headless service for stable DNS entries of members
apiVersion: v1
kind: Service
metadata:
  namespace: depscloud-system
  name: tracker
  labels:
    app: depscloud
spec:
  selector:
    app: tracker
  clusterIP: None
  ports:
  - name: grpc
    port: 8090
    targetPort: 8090
```

To apply, you'll need to install both mysql and the tracker.

```
$ kubectl apply -f manifests/mysql.yaml
$ kubectl apply -f manifests/tracker.yaml
```

These two services are implemented using [gRPC](http://grpc.io).
gRPC enables stream based responses that ease the demand on the remote system during graph traversals.
Since gRPC isn't currently available in the browser, we provide a simple RESTful gateway (`gateway.yaml`) to facilitate communication with the backend systems.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: depscloud-system
  name: gateway
  labels:
    app: depscloud
spec:
  replicas: 3
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: gateway
  template:
    metadata:
      labels:
        app: gateway
    spec:
      initContainers:
      - name: service-precheck
        image: mjpitz/service-precheck:latest
        imagePullPolicy: Always
        args:
        - "des"
        - "dts"
      containers:
      - name: gateway
        image: depscloud/gateway:latest
        imagePullPolicy: Always
        resources:
          limits:
            cpu: 200m
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 100Mi

---
apiVersion: v1
kind: Service
metadata:
  namespace: depscloud-system
  name: gateway
  labels:
    app: depscloud
spec:
  selector:
    app: gateway
  type: LoadBalancer
  ports:
  - name: http
    port: 8080
    targetPort: 8080
```

This system requires the extractor and tracker to be running before it can be started up.

```
$ kubectl apply -f manifests/gateway.yaml
```

The dependency indexer scheduled job (`indexer.yaml`) is deployed on a schedule to allow maintainers of this process to adjust scheduling as needed.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: depscloud-system
  name: rds-config
  labels:
    app: depscloud
data:
  config.yaml: |
    accounts:
    - github:
        strategy: HTTP
        organizations:
        - deps-cloud

---
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  namespace: depscloud-system
  name: indexer
  labels:
    app: depscloud
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          volumes:
          - name: config
            configMap:
              name: rds-config
          initContainers:
          - name: service-precheck
            image: mjpitz/service-precheck:latest
            imagePullPolicy: Always
            args:
            - "extractor"
            - "tracker"
          containers:
          - name: indexer
            image: depscloud/indexer:latest
            imagePullPolicy: IfNotPresent
            args:
            - "--cron"
            - "--rds-config=/etc/rds/config.yaml"
            volumeMounts:
            - name: config
              mountPath: /etc/rds
              readOnly: true
            resources:
              limits:
                cpu: 500m
                memory: 512Mi
              requests:
                cpu: 250m
                memory: 256Mi
          restartPolicy: OnFailure
```

This is the last component that kicks off the whole indexing process.
It can currently be run as a cron or as a daemon, but the preferred deployment is as a a cron.

```
$ kubectl apply -f manifests/indexer.yaml
```

## 3 - Querying the deps.cloud Infrastructure

Once all processes have completed and are healthy, you should be able to interact with the API pretty easily. To quickly test this, you can port forward to one of the `gateway` pods directly.

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

## Deploying in a Single Command

While in the previous sections we ran each process manually, the setup does support applying the configuration all at once.
This can ease the set up process by reducing the manual work involved.
Simply apply all manifests as follows:

```
$ kubectl apply -f manifests/
namespace/depscloud-system created
deployment.apps/extractor created
service/extractor created
configmap/rds-config created
cronjob.batch/indexer created
deployment.apps/tracker created
service/tracker created
deployment.apps/gateway created
service/gateway created
configmap/mysql created
statefulset.apps/mysql created
service/mysql created
service/mysql-read created
```

This is possible through the use of liveness/readiness probes and the [service-precheck](https://github.com/mjpitz/service-precheck) initContainer.
The service-precheck initContainer is responsible for blocking the startup of the pod until upstream service dependencies are ready.
