---
title: "Working with git"
linkTitle: "Working with git"
weight: 30
aliases:
- /docs/contributing/git/
---

## Cloning Projects

Let's get started by creating a workspace for the project.
Many contributors work with Go and follow their convention.

```shell script
mkdir -p ${GOPATH}/src/github.com/depscloud && cd $_
```

Once you have a workspace, you'll want to clone the relevant projects.
Most people contribute to `depscloud` but will also need `deploy` for docker.

```shell script
git clone git@github.com:depscloud/depscloud.git    # source code
git clone git@github.com:depscloud/deploy.git       # deployment config

git clone git@github.com:depscloud/deps.cloud.git   # website
git clone git@github.com:depscloud/api.git          # api and sdk
```

## Branching

The most common way you will likely create a branch is through the use of a GitHub issue within the repository.
To create a branch for GitHub issue #11, simply create a branch with the name `gh-11`.

```bash
$ git checkout -b gh-11
```

## Forking and Submitting Pull Requests

By and large, [forks](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) are used to submit pull requests to the upstream repositories.

After a project has been cloned, you will need to add your fork as a remote.

```bash
$ git remote add <myuser> git@github.com:<myuser>/<project>.git
```

By doing this, you're able to maintain two references: one for upstream updates and one for your set of changes.
When pushing a branch to, you can specify the `-u` option to have your local branch track a specific remote.

```bash
$ git push -u <myuser> gh-11
```

From here, all `git push` operations will default to using your fork.
After a branch has been pushed, you can use [pull requests](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) to have your code reviewed by the team.
