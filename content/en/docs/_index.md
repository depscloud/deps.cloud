---
title: "Documentation"
linkTitle: "Documentation"
menu:
  main:
    weight: 20
no_list: true
aliases:
- /docs/what-is-depscloud/
---

deps.cloud is a tool built to help companies understand how projects relate to one another.
It does this by detecting dependencies defined in common manifest files (`package.json`, `go.mod`, `pom.xml`, etc).
Using this information, we're able to construct a [dependency graph]({{< ref "/docs/concepts/graphs.md" >}}).
As a result we're able to answer questions like:

* Which projects have been indexed?
* Which libraries get produced by a project?
* Which libraries do I depend on and what version?
* Which projects depend on _library X_ and what version?
* Which projects can produce _library X_?
* Which projects do our systems use the most? 

<br/>
<div style="max-width: 80%;">
    <div class="row">
        <div class="col-sm-6">
            <div class="card" style="border:0;padding:20px 0;">
                <div class="card-body text-center">
                    <h5 class="card-title">
                        <a href="{{< ref "/docs/concepts/_index.md" >}}">Concepts</a>
                    </h5>
                    <p class="card-text">
                        Learn about the terminology and core concepts backing the deps.cloud ecosystem.  
                    </p>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="card" style="border:0;padding:20px 0;">
                <div class="card-body text-center">
                    <h5 class="card-title">
                        <a href="{{< ref "/docs/languages/_index.md" >}}">Language Support</a>
                    </h5>
                    <p class="card-text">
                        Learn about the various languages the deps.cloud ecosystem can support.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="card" style="border:0;padding:20px 0;">
                <div class="card-body text-center">
                    <h5 class="card-title">
                        <a href="{{< ref "/docs/guides/_index.md" >}}">User Guides</a>
                    </h5>
                    <p class="card-text">
                        Learn how to consume data from the API and use it to build further capabilities.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="card" style="border:0;padding:20px 0;">
                <div class="card-body text-center">
                    <h5 class="card-title">
                        <a href="{{< ref "/docs/deploy/_index.md" >}}">Deployment</a>
                    </h5>
                    <p class="card-text">
                        Learn how to configure and deploy the deps.cloud ecosystem locally or to clustered environments.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
