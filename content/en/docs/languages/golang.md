---
title: "Golang"
linkTitle: "Golang"
---

All Golang modules can be accessed by querying the `go` language graph in deps.cloud.

```shell script
deps get dependencies -l go -n <name>
deps get dependents -l go -n <name>
```

The names of modules in the deps.cloud graph follow the standard convention for Go.
For example, the deps.cloud Go SDK is `github.com/depscloud/api`.
To determine which libraries the SDK requires:

```shell script
deps get dependencies -l go -n github.com/depscloud/api
```

To determine consumers of the SDK:

```shell script
deps get dependents -l go -n github.com/depscloud/api
```

## Supported Files

deps.cloud builds its `go` graph from the following files.

* `Godeps.json` (`godeps` in the API)
* `go.mod` (`vgo` in the API)
* `Gopkg.toml` (`gopkg` in the API)
* `vendor.conf` (`vendor` in the API)
