---
title: "Deployment"
linkTitle: "Deployment"
weight: 40
no_list: true
aliases:
- /docs/deployment/
---

The deployment of deps.cloud is easy.
While there may still be some rough edges, the intent was to make it possible for any company to drop it into place.
The sections below provide you with details around the various deployment options.

<div class="row" style="max-width: 80%;">
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/docker.png"
      title="Docker"
      link="/docs/deploy/docker/"
      text=""
    >}}
  </div>
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/k8s.png"
      title="Kubernetes"
      link="/docs/deploy/k8s/"
      text=""
    >}}
  </div>
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/helm.png"
      title="Helm"
      link="/docs/deploy/helm/"
      text=""
    >}}
  </div>
</div>

## Configuration

<div class="row" style="max-width: 80%;">
  <div class="col-sm-6 col-md-4" style="padding: 20px 0;">
    {{<card-icon
      border="transparent"
      src=""
      title="Storage"
      link="/docs/deploy/config/storage/"
      text="Configure deps.cloud for PostgreSQL, MySQL, or SQLite"
      >}}
  </div>
  <div class="col-sm-6 col-md-4" style="padding: 20px 0;">
    {{<card-icon
      border="transparent"
      src=""
      title="Indexing"
      link="/docs/deploy/config/indexing/"
      text="Connect deps.cloud to GitHub, GitLab, or BitBucket"
    >}}
  </div>
</div>
