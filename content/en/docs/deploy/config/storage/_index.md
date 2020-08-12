---
title: "Storage"
linkTitle: "Storage"
weight: 10
no_list: true
aliases:
- /docs/deployment/config/storage/
---

deps.cloud was built with portability in mind.
As a result, we wanted to support common relational database systems that we could expect at other companies.
While not officially supported, you could replace the specific technology with a protocol compatible equivalent.
For example, you might replace [MySQL] with [MariaDB] or [Vitess].
Or [PostgreSQL] with something like [CockroachDB].

<div class="row" style="max-width: 80%;">
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/sqlite.png"
      title="SQLite"
      link="/docs/deployment/config/storage/sqlite/"
      text=""
      >}}
  </div>
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/mysql.png"
      title="MySQL"
      link="/docs/deployment/config/storage/mysql/"
      text=""
    >}}
  </div>
  <div class="col-sm-6 col-md-4">
    {{<card-icon
      border="white"
      src="/images/postgres.png"
      title="PostgreSQL"
      link="/docs/deployment/config/storage/postgres/"
      text=""
    >}}
  </div>
</div>

[MySQL]: https://www.mysql.com/
[MariaDB]: https://mariadb.org/
[Vitess]: https://vitess.io/
[PostgreSQL]: https://www.postgresql.org/
[CockroachDB]: https://www.cockroachlabs.com/
