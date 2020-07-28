---
title: Indexer
linkTitle: Indexer
weight: 20
---

* Repository: https://github.com/depscloud/indexer
* Runtime: [Golang](https://golang.org/)
* Language: [Golang](https://golang.org/)

## Background

The indexer process often runs as a cron job.
On a configured schedule, it will re-index all available repositories.
While not ideal, this solution provides an easy way to get started.
If needed, the indexing process can be sharded across multiple different indexers.
This will allow some indexers to run on more frequent intervals while others run on less frequent ones.

## On Cloning

When the indexer clones a repository, it uses `/tmp` to create an ephemeral directory.
It then performs a shallow clone of a repository into that tmp directory.
When the indexing process is complete, all of this is cleaned up.

One thing to be wary of when deploying to your infrastructure is the concurrency induced by the number of `--workers`.
A single worker can process many repositories fairly quick.
Two workers is often more than sufficient.
