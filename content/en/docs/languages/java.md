---
title: "Java"
linkTitle: "Java"
---

All Java dependencies can be accessed by querying the `java` language graph in deps.cloud.

```shell script
deps get dependencies -l java -n <name>
deps get dependents -l java -n <name>
```

deps.cloud uses the concatenation of an artifact's `groupId` and `artifactId` to identify a module.
For example, Google's Guava library is `com.google.guava:guava`.
To determine which libraries Guava requires:

```shell script
deps get dependencies -l java -n com.google.guava:guava
```

To determine users of the Guava library:

```shell script
deps get dependents -l java -n com.google.guava:guava
```

## Supported Formats

deps.cloud builds its `java` graph from the following files.

* `build.gradle` (`gradle` in the API)
* `ivy.xml` (`ivy` in the API)
* `pom.xml` (`maven` in the API)
