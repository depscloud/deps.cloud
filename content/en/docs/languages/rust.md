---
title: "Rust"
linkTitle: "Rust"
---

All Rust dependencies can be accessed by querying the `rust` language graph in deps.cloud.

```shell script
deps get dependencies -l rust -n <name>
deps get dependents -l rust -n <name>
```

Names in the Rust graph follow conventions set by cargo.
For example, config-rs is a popular configuration library for Rust.
To determine which libraries config-rs requires:

```shell script
deps get dependencies -l rust -n config
```

To determine consumers of config-rs:

```shell script
deps get dependents -l rust -n config
```

## Supported Formats

deps.cloud builds its `rust` graph from the following files.

* `cargo.toml` (`cargo` in the API)
