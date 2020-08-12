---
title: "Indexing"
linkTitle: "Indexing"
weight: 20
no_list: true
aliases:
- /docs/integrations/
- /docs/deployment/config/indexing/
---

This section provides guidance on how to configure the underlying system.
Keep in mind, how you update the configuration depends on your deployment strategy.
If you're using Docker, you will be changing the `config.yaml` file.
If you're using Kubernetes, you will need to change the `config.yaml` key in the `depscloud-indexer` `Secret`.

<div class="row" style="max-width: 80%;">
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/github.png"
      title="GitHub"
      link="/docs/deployment/config/indexing/github/"
      text=""
      >}}
  </div>
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/gitlab.png"
      title="GitLab"
      link="/docs/deployment/config/indexing/gitlab/"
      text=""
    >}}
  </div>
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/bitbucket.png"
      title="BitBucket"
      link="/docs/deployment/config/indexing/bitbucket/"
      text=""
    >}}
  </div>
</div>
