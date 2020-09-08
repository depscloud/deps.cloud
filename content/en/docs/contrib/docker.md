---
title: Developing in Docker
linkTitle: Developing in Docker
weight: 40
aliases:
- /docs/contributing/docker/
---

When developing with docker, you'll want to get familiar with how to [deploy the system using Docker](/docs/deploy/docker/).

Each part of the deps.cloud ecosystem has an associated `docker` target that builds a container.
This container can be used with the docker deployment configuration to test changes locally.

| Repository            | Path         | Target           |
|-----------------------|--------------|------------------|
| `depscloud/depscloud` | `/extractor` | `npm run docker` |
| `depscloud/depscloud` | `/gateway`   | `make docker`    |
| `depscloud/depscloud` | `/indexer`   | `make docker`    |
| `depscloud/depscloud` | `/tracker`   | `make docker`    |

Once you've produced an image containing your local changes, you can easily update your stack to pick up the new image.

```shell script
docker-compose up -d
```
