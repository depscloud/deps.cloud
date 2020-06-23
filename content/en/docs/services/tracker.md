---
title: Tracker
type: swagger
weight: 30
date: 2020-06-12
---

* Repository: https://github.com/deps-cloud/tracker
* Runtime: [Golang](https://golang.org/)
* Language: [Golang](https://golang.org/)

## Background

The tracker is a Go process used to encapsulate operations around the database.
It contains four gRPC services, three of which are currently implemented.
The `TopologyService` was initially specified but later implemented as a client-side feature.
While it can be implemented on the server side, the memory and disk requirements vary greatly between queries making it difficult to size appropriately.

## Data Model

At it's core, there are 4 key data models to be aware of in the `tracker` process.
They are `source`, `manages`, `module`, and `depends`.
Both `source` and `module` are nodes in the graph.
`manages` and `depends` are the edges between them.
The following snippet depicts how these components relate to one another.

```
source -->|manages| module
module -->|depends| module 
```

Each component has it's own schema or payload.
The block of YAML below provides a rough idea for the data stored on each item.

```yaml
source:
  url: https://github.com/deps-cloud/api.git

manages:
  language: go|node|java|php
  system: vgo|gopkg|npm|bower|ivy|maven|gradle|composer...
  version: latest

module:
  language: go|node|java|php
  organization: github.com
  module: deps-cloud/api

depends:
  language: go|node|java|php
  version_constraint: ~0.1.0
  scopes:
    - direct
    - indirect
```

These items are then serialized and deserialized into the database.

### Database Schema

The database schema is loosely based off that of Dropbox's [Edgestore](https://www.youtube.com/watch?v=VZ-zJEWi-Vo).
It's since been modified to support more graph type queries, but has proved to work really well.
When looking through the table, you'll notice the data appears as such.

```yaml
graph_item_type: source|manages|module|depends
k1: base64(sha256sum(data))
k2: base64(sha256sum(data))
graph_item_encoding: json
graph_item_data: |
  {
    "key": "value"
  }
```

When `k1` equals `k2`, the item is a node.
In this case, the value for `k1` and `k2` are generated off the item data.
When `k1` != `k2`, the item is an edge between nodes `k1` and `k2`.
This means the current implementation only supports having a single edge between two nodes.
There is some upcoming work that will allow for multiple edges to exist.

## Swagger Explorer

By leveraging the grpc-gateway project, we're able to easily generate Swagger documentation for the API.
This allows you to leverage the Swagger UI to easily browse the API and it's operations.
For convenience, this has been embedded below.

**NOTE:** `api.deps.cloud` require use of the `HTTPS` scheme.
I was unable to find a way to make this the default so be sure to switch.

{{< swaggerui src="https://api.deps.cloud/swagger/v1alpha/tracker/tracker.swagger.json" >}}
