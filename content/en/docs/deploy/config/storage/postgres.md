---
title: "PostgreSQL"
linkTitle: "PostgreSQL"
weight: 30
aliases:
- /docs/deployment/config/storage/postgres/
---

* Driver: `postgres`
* Read-Write Connection String: `postgres://user-rw:password@depscloud-postgresql:5432/depscloud`
* Read-Only Connection String: `postgres://user:password@depscloud-postgresql:5432/depscloud`

## Docker

If using the simple [Docker] set up, these values can be configured using the `--storage-driver`, `--storage-address`, and `--storage-readonly-address` command line arguments.

## Kubernetes

With [Kubernetes], you'll need to configure the secret object manually.
The block below demonstrates how to set up the `depscloud-tracker` configuration for PostgreSQL.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: depscloud-tracker
stringData:
  STORAGE_DRIVER: postrgres
  STORAGE_ADDRESS: postgres://user-rw:password@depscloud-postgresql:5432/depscloud
  STORAGE_READ_ONLY_ADDRESS: postgres://user:password@depscloud-postgresql:5432/depscloud
```

## Helm

With the [Helm] chart, you have two options.
First, you can pass the values into the helm chart as arguments during installation.

```bash
$ helm upgrade -i depscloud depscloud/depscloud \
    --set tracker.storage.driver=postrgres \
    --set "tracker.storage.address=postgres://user-rw:password@depscloud-postgresql:5432/depscloud" \
    --set "tracker.storage.readOnlyAddress=postgres://user:password@depscloud-postgresql:5432/depscloud"
```

Or, you can pass a reference to a secret as described in the previous Kubernetes section.

```bash
$ helm upgrade -i depscloud depscloud/depscloud \
    --set tracker.externalStorage.secretRef.name=depscloud-tracker
```

## Using CockroachDB

Compatibility with [CockroachDB] is not actively tested.
Since CockroachBD claims to be PostgreSQL compatible, there shouldn't be any issues.

[Docker]: {{< ref "/docs/deploy/docker.md" >}}
[Kubernetes]: {{< ref "/docs/deploy/k8s.md" >}}
[Helm]: {{< ref "/docs/deploy/helm.md" >}}

[PostgreSQL]: https://www.postgresql.org/
[CockroachDB]: https://www.cockroachlabs.com/
