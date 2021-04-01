---
title: "Docker"
linkTitle: "Docker"
weight: 10
aliases:
- /docs/deployment/docker/
---

In this quick start guide, we'll use [docker-compose](https://docs.docker.com/compose) to create our demo infrastructure.

To get started quickly, you should clone the [deploy](https://github.com/depscloud/deploy) repository and leverage the configuration under the `docker` directory.
You can pick any storage solution you'd like, but this guide follows the configuration in `sqlite`.

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
You can test it out by installing our command line tool and setting the `DEPSCLOUD_BASE_URL` environment variable.
To learn more, head on over to our [CLI user guide]({{< ref "/docs/guides/cli.md" >}}).

## 2 - Configure Your Provider

Once the demo infrastructure is up and running, you can easily modify the `rds.yaml` file to include more accounts to index.
For more information on how to configure each provider, see the [indexing]({{< ref "/docs/deploy/config/indexing/_index.md" >}}) section.
For now, let's simply add your GitHub ID to the existing block.

```
accounts:
- github:
    strategy: HTTP
    users:
    - { .GitHubLogin }
    organizations:
    - depscloud
```

The configuration will not be automatically reloaded.
Any process consuming the configuration will need to be restarted.

## 3 - Rerun Indexer

The indexer process typically runs as a cronjob.
Because of this, it will pick up the change in configuration on it's next run.
When running locally, we can restart the process to pick up the new configuration.
You may need to re-create the container.

```
$ docker-compose restart indexer
Restarting docker_indexer_1 ... done
```
