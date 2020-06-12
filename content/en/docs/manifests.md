---
title: "Manifest Files"
linkTitle: "Manifest Files"
weight: 5
date: 2020-06-12
---

A manifest is the generic term used to describe documents that communicate a systems requirements or dependencies.
These dependencies come in many shapes and forms, but the most common dependency is a library.
Libraries are packages containing common code that is shared between projects.

Using this information, deps.cloud is able to build a knowledge graph.
The table below demonstrates how this information is extracted from various manifests.
Since there is no standardization across languages, extraction may vary between implementations.

| Manifest File                   | Language | System     | Example                     | Organization       | Module           |
|---------------------------------|----------|------------|-----------------------------|--------------------|------------------|
| `bower.json`                    | `node`   | `bower`    | `@deps-cloud/api`           | `deps-cloud`       | `api`            |
| `build.gradle, settings.gradle` | `java`   | `gradle`   | `com.google.guava:guava`    | `com.google.guava` | `guava`          |
| `cargo.toml`                    | `rust`   | `cargo`    | `bytes`                     | `_`                | `bytes`          |
| `composer.json`                 | `php`    | `composer` | `symfony/console`           | `symfony`          | `console`        |
| `Godeps.json`                   | `go`     | `godeps`   | `github.com/deps-cloud/api` | `github.com`       | `deps-cloud/api` |
| `go.mod`                        | `go`     | `vgo`      | `github.com/deps-cloud/api` | `github.com`       | `deps-cloud/api` |
| `Gopkg.toml`                    | `go`     | `gopkg`    | `github.com/deps-cloud/api` | `github.com`       | `deps-cloud/api` |
| `ivy.xml`                       | `java`   | `ivy`      | `com.google.guava;guava`    | `com.google.guava` | `guava`          |
| `package.json`                  | `node`   | `npm`      | `@deps-cloud/api`           | `deps-cloud`       | `api`            |
| `pom.xml`                       | `java`   | `maven`    | `com.google.guava;guava`    | `com.google.guava` | `guava`          |
| `vendor.conf`                   | `go`     | `vendor`   | `github.com/deps-cloud/api` | `github.com`       | `deps-cloud/api` |
