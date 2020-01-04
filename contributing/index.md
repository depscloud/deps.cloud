---
layout: contrib
title: Contributing
---

All projects are open to contributions.

## Contact Us

There are a few different mechanisms that you can use to get ahold of the team.

* [FindCollabs](https://findcollabs.com/project/deps-cloud-GIOlcUiHE9XD2UVlxrNl) is by and large used for status updates and is checked regularly.
* [Gitter](https://gitter.im/depscloud/community) is used for more back and forth communication and will yield faster response times.

Based on conversations with the team, we decided to leverage Gitter as the primary form of communication.

The [community](https://groups.google.com/a/deps.cloud/forum/#!forum/community/join) meeting is a great way to get face to face time with the members of the team.
It can also be a great way to get introduced to the project and where to get started.
The community meeting is held every two weeks (starting 2019/12/30).
By joining the community Google group, you will automatically receive a calendar event for the meeting.

## Cloning Projects

Once you've forked the repository, you'll want to clone it locally for development.
For convenience, I tend to work out of the GOPATH directory.
Using the following command, you can quickly build a directory for all the deps-cloud related work.

```bash
mkdir -p ${GOPATH}/src/github.com/deps-cloud && cd $_
```

Once you have a workspace, clone the upstream project.
This will allow you to regularly pull updates from the `origin`.

```
git clone git@github.com:deps-cloud/<project>.git
```

## Building and Running Projects

There are two ways you can build and run this project.
First you can develop using docker (the recommended way).
Each repository ships with two dockerfiles, one for building and testing locally, another for publishing.
The second way to build and run this project.
This mechanism is not recommended, but can often help quickly testing things without the overhead of docker.

* [Developing in Docker](develop/docker.md) (Recommended)
* [Developing Locally](develop/local.md)

## Branching

The most common way you will likely create a branch is through the use of a GitHub issue within the repository.
To create a branch for GitHub issue #11, simply create a branch with the name `gh-11`.

```
git checkout -b gh-11
```

In some rare occasions you might be working on a issue that requires work across multiple repositories.
In this case, you should used the deps-cloud-project repository to create a parent issue that the other issues can reference and link to.
To link another projects issue, you can use the `<user>/<project>#11` semantic.
Similarly, you can create a feature branch using the same syntax.

```
git checkout -b <user>/<project>#11
```

## Forking and Submitting Pull Requests

By and large, [forks](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) are used to submit pull requests to the upstream repositories.

After a project has been cloned, you will need to add your fork as a remote.

```
git remote add <myuser> git@github.com:<myuser>/<project>.git
```

By doing this, you're able to maintain two references: one for upstream updates and one for your set of changes.
When pushing a branch to, you can specify the `-u` option to have your local branch track a specific remote.

```
git push -u <myuser> gh-11
```

Fron here, all `git push` operations will default to using your fork.
After a branch has been pushed, you can use [pull requests](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) to have your code reviewed by the team.

## Code of Conduct

deps.cloud is governed by the [Contributor Covenant v1.4.1](/contributing/code-of-conduct/).
