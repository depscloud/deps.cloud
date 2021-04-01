---
title: "Python"
linkTitle: "Python"
---

All Python dependencies can be accessed by querying the `python` language graph in deps.cloud.

```shell script
deps get dependencies -l python -n <name>
deps get dependents -l python -n <name>
```

TensorFlow is a popular library amongst data scientists and machine learning practitioners.
To determine which libraries TensorFlow requires:

```shell script
deps get dependencies -l python -n tensorflow
```

To determine consumers of TensorFlow:

```shell script
deps get dependents -l python -n tensorflow
```

## Supported Formats

deps.cloud builds its `python` graph from the following files.

* `Pipfile` (`pipfile` in the API)
* `requirements.txt` (`pip` in the API)
  * Due to limitations in the `requirements.txt` format, this is currently a best-effort implementation.
