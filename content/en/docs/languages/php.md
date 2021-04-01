---
title: "PHP"
linkTitle: "PHP"
---

All PHP dependencies can be accessed by querying the `php` language graph in deps.cloud.

```shell script
deps get dependencies -l php -n <name>
deps get dependents -l php -n <name>
```

The names of libraries follow the conventions from packagist.
For example, the Symfony framework is `symfony/symfony`.
To determine which libraries Symfony requires:

```shell script
deps get dependencies -l php -n symfony/symfony
```

To determine consumers of Symfony:

```shell script
deps get dependents -l php -n symfony/symfony
```

## Supported Formats

deps.cloud builds its `php` graph from the following files.

* `composer.json` (`composer` in the API)
