---
title: "Manifest Files"
linkTitle: "Manifest Files"
weight: 30
aliases:
- /docs/manifests/
---

A manifest is the generic term used to describe documents that communicate a systems requirements or dependencies.
These dependencies come in many shapes and forms, but the most common dependency is a library.
Libraries are packages containing common code that is shared between projects.

Using this information, deps.cloud is able to build a knowledge graph.
The table below demonstrates how to interpret the information extracted from various manifests.
Since there is no standardization across languages, extraction may vary between implementations.

| Manifest File   | Language | Module Name                 | System     |
|-----------------|----------|-----------------------------|------------|
| `bower.json`    | `js`     | `@depscloud/api`            | `bower`    |
| `build.gradle`  | `java`   | `com.google.guava:guava`    | `gradle`   |
| `cargo.toml`    | `rust`   | `bytes`                     | `cargo`    |
| `composer.json` | `php`    | `symfony/console`           | `composer` |
| `Godeps.json`   | `go`     | `github.com/depscloud/api`  | `godeps`   |
| `go.mod`        | `go`     | `github.com/depscloud/api`  | `vgo`      |
| `Gopkg.toml`    | `go`     | `github.com/depscloud/api`  | `gopkg`    |
| `ivy.xml`       | `java`   | `com.google.guava:guava`    | `ivy`      |
| `package.json`  | `node`   | `@depscloud/api`            | `npm`      |
| `pom.xml`       | `java`   | `com.google.guava:guava`    | `maven`    |
| `vendor.conf`   | `go`     | `github.com/depscloud/api`  | `vendor`   |

## Next Steps

To learn more about how information is stored, head over to the [data model](/docs/concepts/data-model/) documentation.

To learn more about how the system is deployed, head over to the [architecture](/docs/concepts/architecture/) documentation.
