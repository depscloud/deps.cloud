---
title: "Architecture"
linkTitle: "Architecture"
weight: 40
aliases:
- /docs/architecture/
---

The following diagram illustrates the general system deployed on top of a Kubernetes cluster.

![arch](/images/arch.png)

### Actors

[User CLI](https://github.com/depscloud/depscloud/tree/main/deps) represents a single type of consumer.
The command line interface (CLI) allows individuals to explore data stored in deps.cloud.
Other types of clients include processes written using one of our SDKs.

[Gateway](https://github.com/depscloud/depscloud/tree/main/gateway) is the face of the API services.
It provides both RESTful and gRPC interfaces to clients of the system.
Not all functionality is available over the RESTful interface.

[Tracker](https://github.com/depscloud/depscloud/tree/main/tracker) provides several APIs for navigating the graph.
This service leverages systems like as SQLite, MySQL, or PostgreSQL to store the graph data.

[Extractor](https://github.com/depscloud/depscloud/tree/main/extractor) extracts dependency information from manifest files.
This mechanism is easily pluggable to support a large range of manifest files.

The [indexer](https://github.com/depscloud/depscloud/tree/main/indexer) crawls repositories looking for manifest files.
When it discovers manifests, the contents are extracted, stored, and indexed. 
