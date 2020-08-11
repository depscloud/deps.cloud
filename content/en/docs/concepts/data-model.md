---
title: "Data Model"
linkTitle: "Data Model"
weight: 20
aliases:
- /docs/data-model/
---

The backing data model for deps.cloud is a graph.
Graphs contain two types of data: nodes and edges.
Nodes often represent entities such as people, places, or things.
Edges often represent relationships between two entities.

## Overview

The following illustrates the various nodes and edges in the deps.cloud ecosystem.

![data-model](/images/data-model.png)

### Nodes

*Sources* represent origins for information.
These can be source control systems like GitHub, GitLab, or BitBucket.
Or they can be artifactories like JFrog Artifactory or Sonatype Nexus.
Sources are keyed by their URL and are represented as nodes in the dependency graph.

*Modules* represent libraries or applications in the dependency graph.
These are the components extracted from [manifest files](/docs/concepts/manifests/).
They are keyed by all their data, and are represented as nodes in the dependency graph.

### Edges

*Manages* represent the relationship between a *source* and a *module*.
It contains information about how a given module is managed such as the toolchain.

*Depends* represents the relationship between two *modules*.
It contains information about how the modules depend on one another.
This includes things like version constraint, scopes, and a reference to the source.

## Next Steps

To learn about how information is extracted, head over to the [manifest file](/docs/concepts/manifests/) documentation.

To learn more about how the system is deployed, head over to the [architecture](/docs/concepts/architecture/) documentation.
