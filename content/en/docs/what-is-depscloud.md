---
title: "What is deps.cloud?"
linkTitle: "What is deps.cloud?"
weight: 1
date: 2020-04-28
---

<!--<value statement....>-->

deps.cloud was written to help engineers manage changes across a large number of source repositories.
When an organization is small, engineers are often able to reason about how their repositories relate to one another.
While submitting patches is a manual task, it's often something that can be completed quickly.
As an organization grows, the number of repositories often grow as well.
And as the number repositories grow, reasoning about how they relate to one another becomes a challenge. 

To solve this problem, deps.cloud stores this information in a queryable dependency graph.
It does this by parsing and indexing [manifest files](/docs/manifests/) that communicate a given projects requirements.
In NodeJS, this is often a `package.json` file.
In Java, a `pom.xml` or `build.gradle`.

## What problems can deps.cloud solve?

* Identify heavily used open source solutions across your code base
* Propagate updates for security vulnerabilities across impacted projects
* Refactor interfaces and clean up deprecated code

## Further Reading

* [Manifest Files](/docs/manifests/)
* [Architecture](/docs/architecture/)
* [Integrations](/docs/integrations/)
