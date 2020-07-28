---
title: "Data Model"
linkTitle: "Data Model"
weight: 15
---

This page serves as documentation of the open source data model for the deps.cloud system.

## Logical Model

The logical model is the user facing representation of the data in the system.
It is defined using [protocol buffers](https://developers.google.com/protocol-buffers/).
The complete schema can be found in the [API](https://github.com/depscloud/api) repository.
To summarize, there are four distinct entities in the deps.cloud database.

*Sources* represent origins for information.
These can be source control systems like GitHub, GitLab, or BitBucket.
Or they can be artifactories like JFrog Artifactory or Sonatype Nexus.
Sources are keyed by their URL and are represented as nodes in the dependency graph.

*Modules* represent libraries or applications in the dependency graph.
Modules are extracted from [manifest files](/docs/manifests/).
They are keyed by all their data, and are represented as nodes in the dependency graph.

*Manages* represent the relationship between a *source* and a *module*.
It contains information about how a given module is managed such as the toolchain.

*Depends* represents the relationship between two *modules*.
It contains information about how the modules depend on one another.
This includes things like version constraint, scopes, and a reference to the source.

This data can be visualized as such:

![data-model](/images/data-model.png)

## Database Schema

The database schema was inspired by [EdgeStore](https://youtu.be/VZ-zJEWi-Vo?t=588) at [Dropbox](https://dropbox.tech/infrastructure/reintroducing-edgestore).
With a few modifications, we were able to successfully model a dependency graph.
Below, you will find a copy of a create table statement for MySQL. 

```mysql
CREATE TABLE IF NOT EXISTS `dts_graphdata` (
  `graph_item_type` varchar(55) NOT NULL,
  `k1` char(64) NOT NULL,
  `k2` char(64) NOT NULL,
  `k3` varchar(64) NOT NULL,
  `encoding` tinyint DEFAULT NULL,
  `graph_item_data` text,
  `last_modified` datetime DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`graph_item_type`,`k1`,`k2`,`k3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

This schema is able to represent a dependency graph with the help of a few simple rules.

1. When `k1 == k2`, the row represents a node in the graph
2. When `k1 != k2`, the row represents an edge between `k1` and `k2`
3. `k3` allows for multiple edges to exist between nodes, but is restricted to one per source

To help make this more concrete, consider the following simplified table: 

```
| graph_item_type | k1     | k2     | k3     | encoding | graph_item_data |
|-----------------|--------|--------|--------|----------|-----------------|
| depends         | msha   | osha   | ssha   |        1 | { ... }         |
| manages         | ssha   | msha   |        |        1 | { ... }         |
| module          | msha   | msha   |        |        1 | { ... }         |
| module          | osha   | osha   |        |        1 | { ... }         |
| source          | ssha   | ssha   |        |        1 | { ... }         |
```

The following statements can be made about the data shown in the table.

* Source `ssha` manages module `msha`.
* Module `msha` depends on module `osha` for source `ssha`.

## Swappable Storage Engines

While only SQL support is available today, it's possible to support NoSQL systems too.
This is made possible by the simplified schema and data abstraction layer.
Current database support:

* [SQLite](https://www.sqlite.org/)
* [MySQL](https://www.mysql.com/)
* [Postgres](https://postgresql.org/)
