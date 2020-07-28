---
title: "Bitbucket"
linkTitle: "Bitbucket"
weight: 30
---

BitBucket is a common provider used by those seeking private repository support with great integration into existing Atlassian products (like Jira and Confluence).
Below is the complete set of options that can be used to configure your integration.
Either `basic` or `oauth` should be provided.
Otherwise, you will only have access to public repositories.
I've found that `basic` using an [application password](https://confluence.atlassian.com/bitbucket/app-passwords-828781300.html) has been the easiest to configure.

```yaml
accounts:
# full bitbucket schema
- bitbucket:
    users:
    - <username>
    teams:
    - <teamname>
    strategy: SSH | HTTP
    basic:
      username: <username>
      password: <app_password>
    oauth:
      token: <oauth_token>
      application_id: <application_id>
```

Due to the variance in each of the client, there are a few oddities between each of the implementations.
While we work on getting parity between each of the providers take note that this implementation:
* does not pull groups for the authenticated user
* does not pull groups for the configured users
* pulls repositories for all configured users and groups

## Example

Crawl all of Atlassian's public repositories on [BitBucket](https://api.bitbucket.org/2.0/repositories/atlassian).

```yaml
accounts:
- bitbucket:
    teams:
    - atlassian
    strategy: HTTP
```
