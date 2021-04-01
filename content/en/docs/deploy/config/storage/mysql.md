---
title: "MySQL"
linkTitle: "MySQL"
weight: 20
aliases:
- /docs/deployment/config/storage/mysql/
---

* Driver: `mysql`
* Read-Write Connection String: `user-rw:password@tcp(depscloud-mysql:3306)/depscloud`
* Read-Only Connection String: `user:password@tcp(depscloud-mysql:3306)/depscloud`

## Docker

If using the simple [Docker] set up, these values can be configured using the `--storage-driver`, `--storage-address`, and `--storage-readonly-address` command line arguments.

## Kubernetes

With [Kubernetes], you'll need to configure the secret object manually.
The block below demonstrates how to set up the `depscloud-tracker` configuration for MySQL.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: depscloud-tracker
stringData:
  STORAGE_DRIVER: mysql
  STORAGE_ADDRESS: user-rw:password@tcp(depscloud-mysql:3306)/depscloud
  STORAGE_READ_ONLY_ADDRESS: user:password@tcp(depscloud-mysql:3306)/depscloud
```

## Helm

With the [Helm] chart, you have two options.
First, you can pass the values into the helm chart as arguments during installation.

```bash
$ helm upgrade -i depscloud depscloud/depscloud \
    --set tracker.storage.driver=mysql \
    --set "tracker.storage.address=user-rw:password@tcp(depscloud-mysql:3306)/depscloud" \
    --set "tracker.storage.readOnlyAddress=user:password@tcp(depscloud-mysql:3306)/depscloud"
```

Or, you can pass a reference to a secret as described in the previous Kubernetes section.

```bash
$ helm upgrade -i depscloud depscloud/depscloud \
    --set tracker.externalStorage.secretRef.name=depscloud-tracker
```

## Using MariaDB

Compatibility with [MariaDB] is not actively tested.
Since MariaDB claims to be MySQL compatible, there shouldn't be any issues.

## Using Vitess

Compatibility with [Vitess] has not yet been tested.
Since Vitess claims to be MySQL compatible, there shouldn't be any issues.
Contributions are welcome!

[Docker]: {{< ref "/docs/deploy/docker.md" >}}
[Kubernetes]: {{< ref "/docs/deploy/k8s.md" >}}
[Helm]: {{< ref "/docs/deploy/helm.md" >}}

[MySQL]: https://www.mysql.com/
[MariaDB]: https://mariadb.org/
[Vitess]: https://vitess.io/
