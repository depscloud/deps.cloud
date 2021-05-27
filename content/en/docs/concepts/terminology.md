---
title: "Terminology"
linkTitle: "Terminology"
weight: 5

---

### Manifest file

Manifest file is the term used to refer to common dependency management files.
In NodeJS, `package.json` is used to declare dependencies that your project requires.
In Java, you might use `build.gradle` or a `pom.xml` depending on our build chain.
`go.mod` in Go, `Pipfile` in Python, the list goes for many languages.

Simply put, a manifest file can be thought of as any file that communicates what a software project needs.
It's through these files that deps.cloud is able to construct its knowledge graph.

### Source

Sources dictate where a given library can be found.
A source might be a repository on GitHub or in GitLab.
It might be an artifactory like JFrog, Sonatype Nexus, or even a Helm Repository.

Currently, deps.cloud marks sources using their raw URL.
We are working on formalizing a provider URL concept that will decouple the discovery source from repository URLs.   

### Module

Modules in deps.cloud can represent a library (the common case), application, or repository.
This can largely depend on how a given organization manages their repositories and dependencies.
Do you use a monorepo or do you have a repo per service?
Is each service allowed their own set of dependencies or do you pull from one common pool?

<!-- todo: illustrate this -->

### Dependency

Dependencies are the connective tissue of deps.cloud.
A dependency defines a relationship between two modules.
Specifically a directed, versioned, and historical relationship.
It's this type of relationship that makes modeling data in traditional data stores difficult.

There are many graph databases out there that handle this type of relationship well.

### Dependent

Dependents is the inverse of dependency.
A good way to think about this association is through familial bonds.

> my child _depends_ on me (dependency), and my _dependents_ include my child... at least until their older  

This is intended to demonstrate that the dependency property is reflexive (i.e. it can be turned back on itself).
As we traverse edges in our graph, it's important we maintain the direction we are traversing.
