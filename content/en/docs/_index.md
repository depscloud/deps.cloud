---
title: "Documentation"
linkTitle: "Documentation"
menu:
  main:
    weight: 20
aliases:
- /docs/what-is-depscloud/
---

deps.cloud is a tool built to help companies understand how projects relate to one another.
It does this by detecting dependencies defined in common [manifest files](/docs/concepts/manifests/).
Using this information, we're able to construct a dependency graph.
As a result we're able to answer questions like:

* Which projects have been indexed?
* Which libraries get produced by a project?
* Which libraries do I depend on and what version?
* Which projects depend on _library X_ and what version?
* Which projects can produce _library X_?
