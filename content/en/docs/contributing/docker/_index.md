---
title: Developing in Docker
linkTitle: Developing in Docker
weight: 40
date: 2020-04-28
---

In order to start developing using Docker, first deploy the stack using the directions .
You can deploy the stack using either SQLite or MySQL as a backend data store.

## Building Local Changes

To help facilitate contributions, each project has a `docker` target that builds the project inside a container.

| Project | Managed by | `docker` Target |
|---|---|---|
| Golang | `Makefile` | `make docker` |
| NodeJS | `package.json` | `npm run docker` |

The target produces a tagged image that you can deployed using the existing [docker example](/docs/deployment/docker/).

## Deploying Local Changes

Once you've produced an image containing your local changes, you can easily update your stack to pick up the new image.

```bash
$ docker-compose up -d
```
