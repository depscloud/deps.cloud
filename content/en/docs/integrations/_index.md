---
title: "Integrations"
linkTitle: "Integrations"
weight: 20
no_list: true
---

This section provides guidance on how to configure the underlying system.
Keep in mind, how you update the configuration depends on your deployment strategy.
If you're using Docker, you will be changing the `rds.yaml` file.
If you're using Kubernetes, you will need to change the `rds-config` `ConfigMap`.

Discovery is responsible for the discovery of repositories from different sources.
These sources include systems like BitBucket, GitHub, and GitLab.
Configuring the system to read from these different sources is rather easy.
See the following configuration guides on how to configure the system for your corresponding provider.

<div class="row" style="max-width: 80%;">
    <div class="col-sm-6 col-md-4">
      {{<card-icon
        border="white"
        icon="fab fa-github-square"
        title="GitHub"
        link="/docs/integrations/github/"
        text="Index user and organization repositories."
        >}}
    </div>
    <div class="col-sm-6 col-md-4">
      {{<card-icon
        border="white"
        icon="fab fa-gitlab"
        title="GitLab"
        link="/docs/integrations/gitlab/"
        text="Index user and group repositories."
      >}}
    </div>
    <div class="col-sm-6 col-md-4">
      {{<card-icon
        border="white"
        icon="fab fa-bitbucket"
        title="BitBucket"
        link="/docs/integrations/bitbucket/"
        text="Index user and team repositories."
      >}}
    </div>
  </div>
