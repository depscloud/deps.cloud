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
It does this by detecting dependencies defined in common [manifest files](/docs/concepts/manifests/).
Using this information, we're able to construct a [dependency graph](/docs/concepts/graphs/).
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
        <div class="col-sm-6 col-md-4">
            {{<card-icon
                border="white"
                src="/images/concepts.png"
                title="Concepts"
                link="/docs/concepts/"
                text="Learn more about the concepts and terminology behind the system, it's data model, and architecture."
            >}}
        </div>
        <div class="col-sm-6 col-md-4">
            {{<card-icon
                border="white"
                src="/images/infinity.png"
                title="Deployment"
                link="/docs/deployment/"
                text="Learn how to configure and deploy the deps.cloud ecosystem locally or to clustered environments."
            >}}
        </div>
        <div class="col-sm-6 col-md-4">
            {{<card-icon
                border="white"
                src="/images/book.png"
                title="User Guides"
                link="/docs/guides/"
                text="Learn how to consume data from the API and use it to build further capabilities."
            >}}
        </div>
        <div class="col-sm-6 col-md-4">
            {{<card-icon
                border="white"
                src="/images/community.png"
                title="Contributing"
                link="/docs/contributing/"
                text="Learn how to give back and contribute to the project. From where to find help to getting started."
            >}}
        </div>
    </div>
</div>
