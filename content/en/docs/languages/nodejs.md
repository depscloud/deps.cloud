---
title: "NodeJS"
linkTitle: "NodeJS"
---

All NodeJS dependencies can be accessed by querying the `node` language graph in deps.cloud.

```shell script
deps get dependencies -l node -n <name>
deps get dependents -l node -n <name>
```

The names of modules in the deps.cloud graph follow the standard convention for npm.
For example, the deps.cloud NodeJS SDK is `@depscloud/api`.
To determine which libraries the SDK requires:

```shell script
deps get dependencies -l node -n @depscloud/api
```

To determine consumers of the SDK:

```shell script
deps get dependents -l node -n @depscloud/api
```

## Supported Formats

deps.cloud builds its `node` graph from the following files.

* `package.json` (`npm` in the API)
