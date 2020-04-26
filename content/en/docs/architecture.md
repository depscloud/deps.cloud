---
title: "Architecture"
linkTitle: "Architecture"
weight: 10
---

This page serves as documentation of the open source architecture for the deps.cloud system.

## Overview

![arch](/images/arch.png)

While there are several components that make up the ecosystem, each of them serve their own purpose.

### Components

[Gateway](https://github.com/deps-cloud/gateway) is the face of the API services.
It provides a RESTful HTTP interface to the backing gRPC services.
See the [gateway docs](/docs/services/gateway/) for more information.

[Tracker](https://github.com/deps-cloud/tracker) provides several APIs for navigating the graph of information.
This service leverages other storage systems such as SQLite or MySQL to store the graph data.
See the [tracker docs](/docs/services/tracker/) for more information.

[Extractor](https://github.com/deps-cloud/extractor) is responsible for looking at different manifest files and extracting dependency information from them.
This mechanism is easily pluggable to support a large range of different manifest files.
See the [extractor docs](/docs/services/extractor/) for more information.

The [indexer](https://github.com/deps-cloud/indexer) is responsible for fetching repository information, cloning and crawling it, leveraging the extractor and tracker where appropriate.
See the [indexer docs](/docs/services/indexer/) for more information.

The [command line interface](https://github.com/deps-cloud/cli) or CLI provides end users with an easy ability to query the API.
See the [CLI docs](/docs/cli/) for more information.

## Design Decisions

As this system was built out, there were several key decisions that were made along the way.
In this section, I capture several of the frequently asked questions and document the rationale behind them.

### _How should services communicate?_

There are many different ways services can communicate.
REST and [gRPC](https://grpc.io) are simply two of them.
While there are many options out there, there were many benefits that came along with leveraging gRPC.
This includes, but is not limited to:

* contractual API definitions using [Protocol Buffers](https://developers.google.com/protocol-buffers)
* support for multi-language systems
* built in client side load balancing and health checking   

In the end, I decided to leverage gRPC.
As a result, it's had a great impact on the ecosystem.
It allowed parts to be prototyped in one language, and rewritten when they didn't scale.
Adding REST support was easy with the help of the [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway) project.

### _How should the data be stored?_

When you think of a dependency graph, it's easy to jump to the conclusion to use one of the existing [graph databases](https://en.wikipedia.org/wiki/Graph_database) out there.
However, when working with folks in the open source community, it's hard to find people with prior experience on graph databases.
Most people are still more familiar with things like [MySQL](https://www.mysql.com/) or [MongoDB](https://www.mongodb.com/).

Knowing that this layer of the stack was likely to be swapped out with Company X's preferred store, I wanted it to be pluggable.
So the first implementation was done on top of a SQL system.
From there, a simple service interface was born.
This makes it easy to swap the storage technology out for different solutions.
