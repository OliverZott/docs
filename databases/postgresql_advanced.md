# Postgresql

## Dump and Restore

- For flexible, reliable **backups/restores** → `pg_dump -Fc` (Custom format).
- For restoring into an existing DB and overwriting objects → add `pg_restore --clean`.
- **Avoid** -c in dumps unless you specifically want DROP statements baked into the SQL file. It’s **cleaner** to control that at restore time!!!

**Example**

```shell
# sql dump from DataGrip
"C:/Program Files/PostgreSQL/17/bin/pg_dump.exe" 
--dbname=abfall --file="C:\Users\olive\postgres_localhost-2026_02_09_06_19_24-dump.sql" --format=c 
--username=postgres 
--host=localhost 
--port=5432

# pg_restore from DataGrip
"C:/Program Files/PostgreSQL/17/bin/pg_dump.exe" 
--dbname=abfall 
--file="C:\\Users\\olive\\{data_source}-{timestamp}-dump.sql"
--clean --if-exists --format=c
```

```shell
# pg_dump from CLI
pg_dump -U postgres -d source_db -Fc -f source_db.dump

# restore from CLI
pg_restore -U postgres -d target_db --clean --if-exists source_db.dump
```
