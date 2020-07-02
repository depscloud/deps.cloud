---
title: "Command Line"
linkTitle: "Command Line"
weight: 40
date: 2020-07-01
---

* Repository: https://github.com/depscloud/cli
* Runtime: [Golang](https://golang.org/)
* Language: [Golang](https://golang.org/)

## Background

Prior to the command line tool (CLI) existing, the only way to interact with the system was through the RESTful API.
It helps obfuscate the specifics about each endpoint by encapsulating them behind a target.
Currently, this tool provides read only access to API.

```bash
$ deps get -h
Retrieve information from the graph

Usage:
  deps get [command]

Available Commands:
  dependencies Get the list of modules the given module depends on
  dependents   Get the list of modules that depend on the given module
  modules      Get a list of modules from the service
  sources      Get a list of source repositories from the service

Flags:
  -h, --help   help for get

Use "deps get [command] --help" for more information about a command.
```

## Installation

You can install our CLI a few different ways.
On Ubuntu, you can tap our `apt` repository.

```bash
$ echo "deb [trusted=yes] https://apt.fury.io/depscloud/ /" | sudo tee /etc/apt/sources.list.d/depscloud.list
$ sudo apt-get update
$ sudo apt-get install depscloud-cli

$ deps version
deps {version: 0.0.13, commit: a99e9a737103b7b79294b3b754e005c49267cdbd, date: 2020-06-27T22:21:27Z}
```

On OSX, you can tap our [Homebrew](https://brew.sh/) repository.

```bash
$ brew tap depscloud/tap
$ brew install depscloud-cli

$ deps version
deps {version: 0.0.13, commit: a99e9a737103b7b79294b3b754e005c49267cdbd, date: 2020-06-27T22:21:27Z}
```

Finally, you can download one of the latest binaries from GitHub releases.

https://github.com/depscloud/cli/releases/latest

## Configuration

The `deps` can be configured to point at a custom deployment of the deps.cloud ecosystem.
This is done using the `DEPSCLOUD_BASE_URL` environment variable.
Here's an example of how to configure it to use the public API (default behavior) 

```bash
export DEPSCLOUD_BASE_URL="https://api.deps.cloud"
```

If you're trying things out locally, you can also point it at an instance running in [docker](/docs/deployment/docker).

```bash
export DEPSCLOUD_BASE_URL="http://localhost:8080"
```

## Use Cases

There are many use cases that this tool supports.
This section details several sample queries to help get folks started.

### Modules

Modules represent both libraries and applications in the dependency graph.
These can be queried for in one of two ways.
The first option is to list all modules the service knows about.

```bash
$ deps get modules
...
```

The second option is to list all modules produced by a given repository.
To query for this information, simply add the `--url` or `-u` flag.

```bash
$ deps get modules -u https://github.com/depscloud/api.git
{"manages":{"language":"go","system":"vgo","version":"latest"},"module":{"language":"go","organization":"github.com","module":"depscloud/api"}}
{"manages":{"language":"node","system":"npm","version":"0.1.0"},"module":{"language":"node","organization":"depscloud","module":"api"}}
```

### Sources

Currently, a source represents a repository.
It can later be used to represent other sources of dependency information (like [Nexus](https://www.sonatype.com/product-nexus-repository) and other artifact repositories).
Similar to `modules`, `sources` can queried multiple ways.
The first option is to list all sources the service knowns about.

```bash
$ deps get sources
...
```

The second option is to list all sources for a given module.
To query or this information, the `--language`, `--organization`, and `--module` flags must be provided.
Alternatively, the corresponding shorthands `-l`, `-o`, and `-m` can be used respectively.

```bash
$ deps get sources -l go -o github.com -m depscloud/api
{"source":{"url":"https://github.com/depscloud/api.git"},"manages":{"language":"go","system":"vgo","version":"latest"}}
```

### Dependents

Dependent modules are those who consume the module you're querying for.
That is, modules who list your module as a dependency.

```bash
$ deps get dependents -l go -o github.com -m depscloud/api
{"depends":{"language":"go","version_constraint":"v0.1.0","scopes":["direct"]},"module":{"language":"go","organization":"github.com","module":"depscloud/gateway"}}
{"depends":{"language":"go","version_constraint":"v0.1.0","scopes":["direct"]},"module":{"language":"go","organization":"github.com","module":"depscloud/tracker"}}
{"depends":{"language":"go","version_constraint":"v0.1.0","scopes":["direct"]},"module":{"language":"go","organization":"github.com","module":"depscloud/indexer"}}
```

### Dependencies

Dependencies are the modules that your module requires.
This should rarely differ from the modules you list in your appropriate manifest file (`package.json`, `go.mod`, etc.)

```bash
$ deps get dependencies -l go -o github.com -m depscloud/api
{"depends":{"language":"go","version_constraint":"v1.3.0","scopes":["direct"]},"module":{"language":"go","organization":"github.com","module":"gogo/protobuf"}}
{"depends":{"language":"go","version_constraint":"v0.3.2","scopes":["indirect"]},"module":{"language":"go","organization":"golang.org","module":"x/text"}}
{"depends":{"language":"go","version_constraint":"v0.0.0-20190628185345-da137c7871d7","scopes":["indirect"]},"module":{"language":"go","organization":"golang.org","module":"x/net"}}
{"depends":{"language":"go","version_constraint":"v1.3.2","scopes":["direct"]},"module":{"language":"go","organization":"github.com","module":"golang/protobuf"}}
{"depends":{"language":"go","version_constraint":"v0.0.0-20190916214212-f660b8655731","scopes":["direct"]},"module":{"language":"go","organization":"google.golang.org","module":"genproto"}}
{"depends":{"language":"go","version_constraint":"v0.0.0-20190626221950-04f50cda93cb","scopes":["indirect"]},"module":{"language":"go","organization":"golang.org","module":"x/sys"}}
{"depends":{"language":"go","version_constraint":"v1.11.2","scopes":["direct"]},"module":{"language":"go","organization":"github.com","module":"grpc-ecosystem/grpc-gateway"}}
{"depends":{"language":"go","version_constraint":"v1.23.1","scopes":["direct"]},"module":{"language":"go","organization":"google.golang.org","module":"grpc"}}
```

### Topology

Topologies are one of the most useful elements of a dependency graph.
They can provide you with the full set of transitive modules, build orders, and notions of parallelism.
While the [tracker](/docs/services/tracker/) API calls out to a `TopologyService`, this has only been implemented as a client side feature.

This is largely because topological queries can be resource intensive.
This is due to the fact that the subgraph needs to be buffered before any results can be returned.
By implementing this as a client-side feature, we defer the memory/disk cost to clients, allowing them to buffer as they see fit while allowing the tracker to be light weight.

Topologies can be queried in both the `dependencies` and `dependents` direction.

```bash
$ deps get dependencies topology -l go -o github.com -m depscloud/api
{"language":"go","organization":"github.com","module":"depscloud/api"}
{"language":"go","organization":"github.com","module":"gogo/protobuf"}
{"language":"go","organization":"golang.org","module":"x/text"}
{"language":"go","organization":"golang.org","module":"x/net"}
{"language":"go","organization":"github.com","module":"golang/protobuf"}
{"language":"go","organization":"google.golang.org","module":"genproto"}
{"language":"go","organization":"golang.org","module":"x/sys"}
{"language":"go","organization":"github.com","module":"grpc-ecosystem/grpc-gateway"}
{"language":"go","organization":"google.golang.org","module":"grpc"}
```

```bash
$ deps get dependents topology -l go -o github.com -m depscloud/api
{"language":"go","organization":"github.com","module":"depscloud/api"}
{"language":"go","organization":"github.com","module":"depscloud/gateway"}
{"language":"go","organization":"github.com","module":"depscloud/cli"}
{"language":"go","organization":"github.com","module":"depscloud/tracker"}
{"language":"go","organization":"github.com","module":"depscloud/indexer"}
```

By adding the `--tiered` flag, you will get a structured set of results back.
This is great for building automation around your source code as it not only identifies the order in which things should be built, but it also provides tiers where parallel builds can occur.
Consider the following simple example.

```bash
$ deps get dependents topology -l go -o github.com -m depscloud/api --tiered
[{"language":"go","organization":"github.com","module":"depscloud/api"}]
[{"language":"go","organization":"github.com","module":"depscloud/gateway"},{"language":"go","organization":"github.com","module":"depscloud/cli"},{"language":"go","organization":"github.com","module":"depscloud/tracker"},{"language":"go","organization":"github.com","module":"depscloud/indexer"}]
```

In this case, we only have two tiers.
Each tier contains a list of modules that can be built in parallel.
When one tier is complete, the next tier can be processed safely without worrying about transitive dependency issues.
