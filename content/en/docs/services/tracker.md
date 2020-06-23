---
title: Tracker
type: swagger
weight: 30
date: 2020-06-12
---

* Repository: https://github.com/deps-cloud/tracker
* Runtime: [Golang](https://golang.org/)
* Language: [Golang](https://golang.org/)

## Background

The tracker is a Go process used to encapsulate operations around the database.
It contains four gRPC services, three of which are currently implemented.
The `TopologyService` was initially specified but later implemented as a client-side feature.
While it can be implemented on the server side, the memory and disk requirements vary greatly between queries making it difficult to size appropriately.

## Swagger Explorer

By leveraging the grpc-gateway project, we're able to easily generate Swagger documentation for the API.
This allows you to leverage the Swagger UI to easily browse the API and it's operations.
For convenience, this has been embedded below.

{{< swaggerui src="https://api.deps.cloud/swagger/v1alpha/tracker/tracker.swagger.json" >}}
