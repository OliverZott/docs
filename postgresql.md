# PostgreSQL

## Install

- `choco install postgresql`
- `choco install pgadmin4`

## Setup User

[Chocolatey Software | PostgreSQL 14.4.1](https://community.chocolatey.org/packages/postgresql "‌")

- If you didn't specify password during setup and didn't record the generated one, you need manually reset it using the following steps:
  - Open file `data\pg_hba.conf` in PostgreSql installation directory
  - Change `METHOD` to `trust` and restart service with `Restart-Service postgresql*`
  - Execute `"alter user postgres with password 'password';" | psql -Upostgres`
  - Revert back `data\pg_hba.conf` to METHOD `md5` and restart service

## Use CLI

``` shell
psql -V
psql -U postgres
```

or Linux:

```shell
sudo -u postgres psql
```

to quit:

```shell
\q
```

Show databases, connect to database and show tables:

```shell
\l
\c <dbName>
\dt
```

Show full history, show useres

```shell
\d
\du
```

Query on table of current connected db.

```shell
SELECT * FROM "<tableName>";
```
