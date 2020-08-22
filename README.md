# deps.cloud documentation

![GitHub Pages](https://img.shields.io/github/deployments/depscloud/deps.cloud/github-pages?label=GitHub%20Pages)

This repository contains the source for the [deps.cloud website, blog, and documentation](https://deps.cloud/).

### Prerequisites

In order to use this repository, you will need the following installed locally.

* [npm](https://www.npmjs.com/)
* [Hugo](https://gohugo.io/)

Before you start, clone the repository and install dependencies.

```shell script
git clone git@github.com:depscloud/deps.cloud.git
cd deps.cloud
make deps
```

### Running the website locally

Once you've installed the dependencies, you can run a local server.

```shell script
hugo serve -D
```

This will start up a server on [localhost:1313](http://localhost:1313).
You should be able to see any changes made to documentation updated in realtime in the browser.

### Contributing a change

When contributing a change, you should submit a pull request from a [fork](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo).
Your fork can be added as a remote to the upstream repository.
This will be the easiest way to stay on top of the latest changes.

```shell script
git remote add [username] git@github.com:[username]/deps.cloud.git
```

All modifications should be commit to a branch.
When a GitHub issue exists for the work you're contributing, you should associate you're branch appropriately.
Otherwise, a simple, descriptive name is sufficient (e.g. `ci_update`.)

```shell script
git checkout -b gh-###
```

### Pushing changes to a fork

When you're ready to submit a pull request, your changes should be pushed to your fork.
From there, you can submit a merge request back to a company. 

```shell script
git push -u [username] gh-###
```

# Support

Join our [mailing list] and ask any questions there.

We also have a [Slack] channel.

[mailing list]: https://groups.google.com/a/deps.cloud/forum/#!forum/community/join
[Slack]: https://depscloud.slack.com/join/shared_invite/zt-fd03dm8x-L5Vxh07smWr_vlK9Qg9q5A

## Code of Conduct

deps.cloud is governed by the [Contributor Covenant v1.4.1](/contributing/code-of-conduct/index.md).

![Google Analytics](https://www.google-analytics.com/collect?v=1&cid=555&t=pageview&ec=repo&ea=open&dp=deps.cloud&dt=deps.cloud&tid=UA-143087272-2)
