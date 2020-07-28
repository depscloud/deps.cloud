---
title: "GitHub"
linkTitle: "GitHub"
weight: 10
---

GitHub is the largest source of repositories.
Most companies have an account where they maintain their code repositories.
Due to the system's popularity, it was one of the first integrations that was targeted.
Below, you'll find the full set of configuration options that can be specified for a GitHub account.

```yaml
accounts:
# full github schema
- github:
    base_url: <base_url>
    upload_url: <base_url>
    users:
    - <username>
    organizations:
    - <organization>
    strategy: SSH | HTTP
    oauth2:
      token: <oauth_token>
      token_type: <token_type>
      refresh_token: <refresh_token>
      expiry: <expiry>
```

Due to the variance in each of the client, there are a few oddities between each of the implementations.
While we work on getting parity between each of the providers take note that this implementation:
* does not pull groups for the authenticated user
* pull groups for the configured users
* pulls repositories for all users and groups (configured and discovered)

## Example

Crawl all of Google's public repositories on [GitHub](https://github.com/google).

```yaml
accounts:
- github:
    organizations:
    - google
    strategy: HTTP
```
