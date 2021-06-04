---
title: "Command Line"
linkTitle: "Command Line"
aliases:
- /docs/cli/
---

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
deps {"version":"0.3.1","commit":"d05c242e8622a7851b228dc8a1cb79f2719c71a6","date":"2021-03-28T04:30:08Z"}
```

On OSX, you can tap our [Homebrew](https://brew.sh/) repository.

```bash
$ brew tap depscloud/tap
$ brew install depscloud-cli

$ deps version
deps {"version":"0.3.1","commit":"d05c242e8622a7851b228dc8a1cb79f2719c71a6","date":"2021-03-28T04:30:08Z"}
```

Finally, you can download the latest `deps` binary from GitHub releases.

https://github.com/depscloud/depscloud/releases/latest

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
{"module":{"language":"node","name":"@depscloud/api"},"edge_data":[{"version":"0.1.19","system":"npm"}]}
{"module":{"language":"go","name":"github.com/depscloud/api"},"edge_data":[{"version":"latest","system":"vgo"}]}
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
To query or this information, the `--language` and `--name` flags must be provided.
Alternatively, the corresponding shorthands `-l` and `-n` can be used respectively.

```bash
$ deps get sources -l go -n github.com/depscloud/api
{"source":{"kind":"repository","url":"https://github.com/depscloud/api.git"},"edge_data":[{"version":"latest","system":"vgo"}]}
```

### Dependents

Dependent modules are those who consume the module you're querying for.
That is, modules who list your module as a dependency.

```bash
$ deps get dependents -l go -n github.com/depscloud/api
{"module":{"language":"go","name":"github.com/depscloud/hacktoberfest"},"edge_data":[{"ref":"https://github.com/depscloud/hacktoberfest.git","version_constraint":"v0.1.19","scopes":["direct"]}]}
{"module":{"language":"go","name":"github.com/depscloud/depscloud"},"edge_data":[{"ref":"https://github.com/depscloud/depscloud.git","version_constraint":"v0.1.19","scopes":["direct"]}]}
```

### Dependencies

Dependencies are the modules that your module requires.
This should rarely differ from the modules you list in your appropriate manifest file (`package.json`, `go.mod`, etc.)

```bash
$ deps get dependencies -l go -n github.com/depscloud/api
{"module":{"language":"go","name":"github.com/grpc-ecosystem/grpc-gateway"},"edge_data":[{"ref":"https://github.com/depscloud/api.git","version_constraint":"v1.15.2","scopes":["direct"]}]}
{"module":{"language":"go","name":"google.golang.org/grpc"},"edge_data":[{"ref":"https://github.com/depscloud/api.git","version_constraint":"v1.33.1","scopes":["direct"]}]}
{"module":{"language":"go","name":"github.com/gogo/protobuf"},"edge_data":[{"ref":"https://github.com/depscloud/api.git","version_constraint":"v1.3.1","scopes":["direct"]}]}
{"module":{"language":"go","name":"github.com/golang/protobuf"},"edge_data":[{"ref":"https://github.com/depscloud/api.git","version_constraint":"v1.4.3","scopes":["direct"]}]}
{"module":{"language":"go","name":"golang.org/x/text"},"edge_data":[{"ref":"https://github.com/depscloud/api.git","version_constraint":"v0.3.2","scopes":["indirect"]}]}
{"module":{"language":"go","name":"google.golang.org/genproto"},"edge_data":[{"ref":"https://github.com/depscloud/api.git","version_constraint":"v0.0.0-20201104152603-2e45c02ce95c","scopes":["direct"]}]}
{"module":{"language":"go","name":"golang.org/x/sys"},"edge_data":[{"ref":"https://github.com/depscloud/api.git","version_constraint":"v0.0.0-20190626221950-04f50cda93cb","scopes":["indirect"]}]}
```

### Topology

Topologies are one of the most useful elements of a dependency graph.
They can provide you with the full set of transitive modules, build orders, and notions of parallelism.

As a result, this operation is rather resource intensive since it needs to buffer the graph before any results can be returned.
By implementing this as a client-side feature, we defer the memory/disk cost to clients, allowing them to buffer as they see fit while allowing the tracker to be light weight.

Topologies can be queried in both the `dependencies` and `dependents` direction.

```bash
$ deps get dependencies topology -l go -n github.com/depscloud/api
{"language":"go","name":"github.com/depscloud/api"}
{"language":"go","name":"github.com/gogo/protobuf"}
{"language":"go","name":"github.com/golang/protobuf"}
{"language":"go","name":"github.com/grpc-ecosystem/grpc-gateway"}
{"language":"go","name":"google.golang.org/grpc"}
{"language":"go","name":"golang.org/x/sys"}
{"language":"go","name":"golang.org/x/text"}
{"language":"go","name":"google.golang.org/genproto"}
```

```bash
$ deps get dependents topology -l go -n github.com/depscloud/api
{"language":"go","name":"github.com/depscloud/api"}
{"language":"go","name":"github.com/depscloud/hacktoberfest"}
{"language":"go","name":"github.com/depscloud/depscloud"}
```

By adding the `--tiered` flag, you will get a structured set of results back.
This is great for building automation around your source code as it not only identifies the order in which things should be built, but it also provides tiers where parallel builds can occur.
Consider the following simple example.

```bash
$ deps get dependents topology -l go -n github.com/depscloud/api --tiered
[{"language":"go","name":"github.com/depscloud/api"}]
[{"language":"go","name":"github.com/depscloud/hacktoberfest"},{"language":"go","name":"github.com/depscloud/depscloud"}]
```

In this case, we only have two tiers.
Each tier contains a list of modules that can be built in parallel.
When one tier is complete, the next tier can be processed safely without worrying about transitive dependency issues.
