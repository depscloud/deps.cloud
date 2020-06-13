---
title: "New Default Branch: main"
author: Mya Pitzeruse
date: 2020-06-13
---

The term 'master' is used heavily across the technical community.
It's used to represent primary instances in a database, branches in repositories, and so much more.
But this term is also associated with racism, oppression, violence, and hate.

To help show our support for the black community, the default branch has been renamed to `main`.
While this is one small change in one project, we hope that many others follow suit.

If you are contemplating making a similar change, it was easy to do with some shell scripting.
The deps.cloud projects took about 30 minutes to migrate, including content auditing.
You can follow along with the snippet below as it was used to move the deps.cloud ecosystem.
While this script is specific to GitHub, it should be easy to modify for other systems.

```bash
# setup credentials for the api

export GITHUB_AUTHORIZATION="token OAUTH-TOKEN"
export GITHUB_GROUP="deps-cloud"
export BRANCH_NAME="main"

# start with a fresh copy of your code (just to be safe)

curl -sSL -H "Authorization: ${GITHUB_AUTHORIZATION}" https://api.github.com/users/${GITHUB_GROUP}/repos | \
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

curl -sSL -H "Authorization: ${GITHUB_AUTHORIZATION}" https://api.github.com/users/${GITHUB_GROUP}/repos | \
    jq -r .[].name | \
    xargs -I{} curl \
        -X PATCH \
        -H "Content-Type: application/json" \
        -d "{\"default_branch\": \"${BRANCH_NAME}\"}" https://api.github.com/repos/${GITHUB_GROUP}/{}

##
## Congratulations!
##
## You've gotten to the point where active development should no longer be against master.
## Now, you don't want to go and delete it quite yet as you might have some external links pointing to the branch.
## You'll want to make sure you do an audit of your projects content, badges, and workflows.
## Once you've verified all the references have been updated, you'll be able to proceed on.
##
## Notes:
## * Some system may require making some additional changes (like setting up protected branches).
##

# delete the master branch

find . -maxdepth 2 -name .git | xargs dirname | xargs -I{} git --git-dir={}/.git --work-tree={} push origin :master
```
