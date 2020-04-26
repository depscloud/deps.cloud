---
title: "Docker"
linkTitle: "Docker"
weight: 10
---

In this quick start guide, we'll use [docker-compose](https://docs.docker.com/compose) to create our demo infrastructure.

To get started quickly, you should clone the [deps.cloud](https://github.com/deps-cloud/deps.cloud) repository and leverage the configuration under the `examples/docker` directory.

## 1 - Launch deps.cloud

To launch the demo infrastructure, simply run the following:

```
$ docker-compose up -d
Creating docker_extractor_1 ... done
Creating docker_tracker_1 ... done
Creating docker_indexer_1     ... done
Creating docker_gateway_1 ... done
```

**That's it!**

The deps.cloud demo infrastructure is up and running.
You can test it out by opening any of the following endpoints (browser or curl).

* [What sources have been indexed?](http://localhost:8080/v1alpha/sources)
* [What modules are produced by this repository?](http://localhost:8080/v1alpha/modules/managed?url=https%3A%2F%2Fgithub.com%2Fdeps-cloud%2Fextractor.git)
* [What modules do I depend on and what version?](http://localhost:8080/v1alpha/graph/go/dependencies?organization=github.com&module=deps-cloud%2Fextractor)
* [What modules depend on me and what version?](http://localhost:8080/v1alpha/graph/go/dependents?organization=github.com&module=deps-cloud%2Fapi)
* [What repositories can produce this module?](http://localhost:8080/v1alpha/modules/source?organization=github.com&module=deps-cloud%2Fextractor&language=go)

## 2 - Configure Your Provider

Once the demo infrastructure is up and running, you can easily modify the `rds.yaml` file to include more accounts to index.
For more information on how to configure each integration, see the [integrations](/docs/integrations/) section.
For now, let's simply add your GitHub ID to the existing block.

```
accounts:
- github:
    strategy: HTTP
    users:
    - { .GitHubLogin }
    organizations:
    - deps-cloud
```

The configuration will not be automatically reloaded.
Any process consuming the configuration will need to be restarted.

## 3 - Rerun Indexer

The indexer process is typically run as a cronjob.
Because of this, it will typically pick up the configuration on it's next run.
When running locally, we can restart the process to pick up the new configuration.
You may need to re-create the container.

```
$ docker-compose restart indexer
Restarting docker_indexer_1 ... done
```
