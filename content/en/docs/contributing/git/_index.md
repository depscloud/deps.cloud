---
title: "Working with Git"
linkTitle: "Working with Git"
weight: 30
---

## Cloning Projects

Once you've forked the repository, you'll want to clone it locally for development.
For convenience, I tend to work out of the GOPATH directory.
Using the following command, you can quickly build a directory for all the deps-cloud related work.

```bash
$ mkdir -p ${GOPATH}/src/github.com/deps-cloud && cd $_
```

Once you have a workspace, clone the upstream project.
This will allow you to regularly pull updates from the `origin`.

```bash
$ git clone git@github.com:deps-cloud/<project>.git
```

## Building and Running Projects

There are two ways you can build and run this project.
First you can develop using docker (the recommended way).
Each repository ships with two dockerfiles, one for building and testing locally, another for publishing.
The second way to build and run this project.
This mechanism is not recommended, but can often help quickly testing things without the overhead of docker.

* [Developing in Docker](developing-in-docker/) (Recommended)
* [Developing Locally](developing-locally/)

## Branching

The most common way you will likely create a branch is through the use of a GitHub issue within the repository.
To create a branch for GitHub issue #11, simply create a branch with the name `gh-11`.

```bash
$ git checkout -b gh-11
```

In some rare occasions you might be working on a issue that requires work across multiple repositories.
In this case, you should used the [deps.cloud](https://github.com/deps-cloud/deps.cloud) repository to create a parent issue that the other issues can reference and link to.
To link another projects issue, you can use the `<user>/<project>#11` semantic.
Similarly, you can create a feature branch using the same syntax.

```bash
$ git checkout -b <user>/<project>#11
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

Fron here, all `git push` operations will default to using your fork.
After a branch has been pushed, you can use [pull requests](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) to have your code reviewed by the team.
