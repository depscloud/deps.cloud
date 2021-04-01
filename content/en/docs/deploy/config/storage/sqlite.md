---
title: "SQLite"
linkTitle: "SQLite"
weight: 10
aliases:
- /docs/deployment/config/storage/sqlite/
---

* Storage Driver: `sqlite`
* Read-Write Connection String: `file:depscloud.db?cache=shared&mode=rwc`
* Read-Only Connection String: `file:depscloud.db?cache=shared&mode=ro`

## Docker

If using the simple [Docker] set up, these values can be configured using the `--storage-driver`, `--storage-address`, and `--storage-readonly-address` command line arguments.

## Kubernetes

With [Kubernetes], you'll need to configure the secret object manually.
The block below demonstrates how to set up the `depscloud-tracker` configuration for SQLite.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: depscloud-tracker
stringData:
  STORAGE_DRIVER: sqlite
  STORAGE_ADDRESS: file:depscloud.db?cache=shared&mode=rwc
  STORAGE_READ_ONLY_ADDRESS: file:depscloud.db?cache=shared&mode=ro
```

## Helm

With the [Helm] chart, you have two options.
First, you can pass the values into the helm chart as arguments during installation.

```bash
$ helm upgrade -i depscloud depscloud/depscloud \
    --set tracker.storage.driver=sqlite \
    --set "tracker.storage.address=file:depscloud.db?cache=shared&mode=rwc" \
    --set "tracker.storage.readOnlyAddress=file:depscloud.db?cache=shared&mode=ro"
```

Or, you can pass a reference to a secret as described in the previous Kubernetes section.

```bash
$ helm upgrade -i depscloud depscloud/depscloud \
    --set tracker.externalStorage.secretRef.name=depscloud-tracker
```

[Docker]: {{< ref "/docs/deploy/docker.md" >}}
[Kubernetes]: {{< ref "/docs/deploy/k8s.md" >}}
[Helm]: {{< ref "/docs/deploy/helm.md" >}}
