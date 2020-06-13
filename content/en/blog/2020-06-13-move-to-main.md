---
title: "New Default Branch: main"
author: Mya Pitzeruse
date: 2020-06-13
---

The default branch for all repositories under the deps.cloud ecosystem has changed from `master` to `main`.
The change was made to help show support for the black community and stand with them against systematic racism, violence, and hate.

For those contemplating making a similar change, this was pretty easy to do with some shell scripting.
The snippet below was largely used to move the deps.cloud ecosystem:

```bash
# setup credentials for the api

export GITHUB_AUTHORIZATION="token OAUTH-TOKEN"
export GITHUB_GROUP="deps-cloud"
export BRANCH_NAME="main"

# start with a fresh copy of your code (just to be safe)

curl -sSL -H "Authorization: ${GITHUB_AUTHORIZATION}" "https://api.github.com/users/${GITHUB_GROUP}/repos" | \
    jq -r .[].ssh_url | \
    xargs -I{} git clone {}

# checkout a new branch and push it

find . -maxdepth 2 -name .git | \
    xargs dirname | \
    xargs -I{} git --git-dir={}/.git --work-tree={} checkout -b ${BRANCH_NAME}

find . -maxdepth 2 -name .git | \
    xargs dirname | \
    xargs -I{} git --git-dir={}/.git --work-tree={} push -u orgin ${BRANCH_NAME}

# update the default branch

curl -sSL -H "Authorization: ${GITHUB_AUTHORIZATION}" "https://api.github.com/users/${GITHUB_GROUP}/repos" | \
    jq -r .[].name | \
    xargs -I{} curl \
        -X PATCH \
        -H "Content-Type: application/json" \
        -d "{\"default_branch\": \"${BRANCH_NAME}\"}" "https://api.github.com/repos/${GITHUB_GROUP}/{}"

## Congratulations!
## You've gotten to the point where your default branch is no longer master.
## Now, you don't want to go and delete that quite yet as you might have some external links.
## You'll want to make sure you do an audit of your content, badges, and workflows.
## Once you've verified all the links have been updated, you'll be able to proceed on.
## Some system may require making some additional changes (like setting up protected branches).

# delete the master branch

$ find . -maxdepth 2 -name .git | xargs dirname | xargs -I{} git --git-dir={}/.git --work-tree={} push origin :master
```
