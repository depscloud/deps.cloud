---
title: "Manifest Files"
linkTitle: "Manifest Files"
weight: 20
aliases:
- /docs/manifests/
---

A manifest is the generic term used to describe documents that communicate a systems requirements or dependencies.
These dependencies come in many shapes and forms, but the most common dependency is a library.
Libraries are packages containing common code that is shared between projects.

Using this information, deps.cloud is able to build a knowledge graph.
The table below demonstrates how to interpret the information extracted from various manifests.
Since there is no standardization across languages, extraction may vary between implementations.

| Manifest File                   | Example                     | Language | System     | Organization       | Module           |
|---------------------------------|-----------------------------|----------|------------|--------------------|------------------|
| `bower.json`                    | `@depscloud/api`            | `node`   | `bower`    | `depscloud`        | `api`            |
| `build.gradle, settings.gradle` | `com.google.guava:guava`    | `java`   | `gradle`   | `com.google.guava` | `guava`          |
| `cargo.toml`                    | `bytes`                     | `rust`   | `cargo`    | `_`                | `bytes`          |
| `composer.json`                 | `symfony/console`           | `php`    | `composer` | `symfony`          | `console`        |
| `Godeps.json`                   | `github.com/depscloud/api`  | `go`     | `godeps`   | `github.com`       | `depscloud/api`  |
| `go.mod`                        | `github.com/depscloud/api`  | `go`     | `vgo`      | `github.com`       | `depscloud/api`  |
| `Gopkg.toml`                    | `github.com/depscloud/api`  | `go`     | `gopkg`    | `github.com`       | `depscloud/api`  |
| `ivy.xml`                       | `com.google.guava;guava`    | `java`   | `ivy`      | `com.google.guava` | `guava`          |
| `package.json`                  | `@depscloud/api`            | `node`   | `npm`      | `depscloud`        | `api`            |
| `pom.xml`                       | `com.google.guava;guava`    | `java`   | `maven`    | `com.google.guava` | `guava`          |
| `vendor.conf`                   | `github.com/depscloud/api`  | `go`     | `vendor`   | `github.com`       | `depscloud/api`  |
