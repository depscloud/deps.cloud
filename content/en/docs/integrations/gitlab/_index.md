---
title: "GitLab"
linkTitle: "GitLab"
weight: 20
date: 2020-06-12
---

GitLab is a common provider used by those seeking an on-premise solution who do not want their source code managed by a third party provider.
Many companies choose to run this system internally.
Below, you will find the list of options that can be configured to get the system running.
Either `private` or `oauth` should be provided.
Otherwise, you will only have access to public repositories.
I've found configuring the [`private` token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html) to be the easiest.

```yaml
accounts:
# full gitlab schema
- gitlab:
    base_url: <base_url>
    users:
    - <username>
    groups:
    - <groupname>
    strategy: SSH | HTTP
    private:
      token: <private_token>
    oauth:
      token: <oauth_token>
      application_id: <application_id>
```

Due to the variance in each of the client, there are a few oddities between each of the implementations.
While we work on getting parity between each of the providers take note that this implementation:
* pulls groups for the authenticated user
* does not pull groups for the configured users
* pulls repositories for all users and groups (configured and discovered)

## Example

Crawl all of Nvidia's public repositories on [GitLab](https://gitlab.com/nvidia).

```yaml
accounts:
- gitlab:
    groups:
    - nvidia
    strategy: HTTP
```
