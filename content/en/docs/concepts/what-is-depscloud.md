---
title: "What is deps.cloud?"
linkTitle: "What is deps.cloud?"
weight: 1
aliases:
- /docs/what-is-depscloud/
---

deps.cloud is a tool built to help engineers understand how their projects relate to one another.
When an organization is small, this is a rather easy thing to do.
As an organization grows, the number of repositories often grow as well.
As the number repositories grow, reasoning about how they relate to one another often becomes a challenge. 

To solve this problem, deps.cloud stores information in a queryable dependency graph.
It does this by parsing and indexing [manifest files](/docs/manifests/) that communicate a given projects requirements.
In NodeJS, this is often a `package.json` file.
In Java, a `pom.xml` or `build.gradle`.

## What problems can deps.cloud solve?

_Identify heavily used open source solutions across your code base_

Regardless of organization size, deps.cloud can help track open source libraries and their use across your ecosystem.
Monitor direct consumers of an open source project as well as the full dependency tree.

_Refactor interfaces and clean up deprecated code_

Changing existing interfaces can often be problematic.
You often need to provide two versions of a method, publish a new version of the library, update all consumers, and remove the old method.
This process can often take several versions to roll through completely.
With deps.cloud, you can be proactive in propagating changes across library consumers.

_Propagate updates for security vulnerabilities across impacted projects_

Using libraries means you eventually have to handle an upgrade to address a CVE.
deps.cloud not only show what systems are consuming a potentially vulnerable library, but also the versions used by your ecosystem. 

## Further Reading

* [Manifest Files](/docs/manifests/)
* [Architecture](/docs/architecture/)
* [Integrations](/docs/integrations/)
