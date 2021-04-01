---
title: "Helm"
linkTitle: "Helm"
---

All Helm Charts can be accessed by querying the `helm` language graph in deps.cloud.

```shell script
deps get dependencies -l helm -n <name>
deps get dependents -l helm -n <name>
```

deps.cloud uses the name of the chart to identify modules in the graph.
For example, the deps.cloud project consists of several charts composed together.
You can deploy each component individually, or you can use `depscloud` to deploy the whole ecosystem.
To see the charts used by the `depscloud` chart: 

```shell script
deps get dependencies -l helm -n depscloud
```

To determine what charts require the `mysql` chart:

```shell script
deps get dependents -l helm -n mysql
```

## Supported Files

deps.cloud builds its `helm` graph from the following files.

* `Chart.yaml` (`helm` in the API)
  * Must be in the `apiVersion: v2` format
