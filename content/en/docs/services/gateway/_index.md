---
title: Gateway
linkTitle: Gateway
weight: 10
date: 2020-04-28
---

* Repository: https://github.com/deps-cloud/gateway
* Runtime: [Golang](https://golang.org/)
* Language: [Golang](https://golang.org/)

## Background

Gateway is an extremely thin, lightweight, reverse proxy.
It provides a RESTful interface that translates requests into gRPC calls.
This is done using the [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway) project.
`grpc-gateway` provides a library and several Protocol Buffer plugins.
These plugins make it possible to annotate service calls defined in `.proto` files with RESTful semantics.
These annotations are used to generate associated HTTP handlers and [Swagger](https://swagger.io/) documentation.

In addition to servicing requests, it aggregates both the [extractor](/docs/services/extractor) and [tracker](/docs/services/tracker) systems behind a single interface.
This makes configuring tools like the [CLI](/docs/cli) a lot easier.

## Swagger Explorers

In addition to serving the API, it also serves the associated swagger documentation.
You can explore the API further at the links below.

* [Extractor Swagger](/docs/services/extractor/#swagger-explorer)
* [Tracker Swagger](/docs/services/tracker/#swagger-explorer)
