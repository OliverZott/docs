# MySql

## CLI

```bash
winget show MariaDB.Server
winget show MySQL.Server

mysql -u [username] -p  # Login
mysql -u [username] -p --port=[port_number]  # login with specific port

mysql -u root -p  --port=3307  # connect to mariadb (installed on port 3307)
mysql -u root -p  --port=3306  # connect to mysql (installed on port 3306)
SHOW DATABASES;  # Show all databases:

# Show all tables in a specific database:
USE [database_name];  
SHOW TABLES;

# Show general information about the database:
SELECT VERSION();
SELECT DATABASE();
STATUS;

# Show users and their roles:
SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'username'@'host';

quit
```

## Example queries

```sql
SELECT * FROM <dbname>.<table_name>;

SELECT * FROM mytable ORDER BY id DESC LIMIT 5;

SHOW KEYS FROM <dbname>.<table_name> WHERE Key_name = 'PRIMARY';

UPDATE mydb.mytable
SET col1 = value1, col2 = value2, col3 = value3
WHERE id LIKE idval;

UPDATE mydb.mytable SET 
TELEFON = "123",
NAME3 = CASE WHEN MOD(ID, 4) IN (0, 1) THEN 'Herr John Doe' ELSE 'Frau Jane Doe' END,
VORNAME = CASE WHEN MOD(ID, 4) IN (0, 1) THEN 'John' ELSE 'Jane' END,
ZUNAME = "Doe",
EMAIL = CASE WHEN MOD(ID, 4) IN (0, 1) THEN 'john@doe.com' ELSE 'jane@doe.com' END
WHERE NAME1 NOT LIKE '%special%'
  AND NAME3 NOT LIKE '%test%';

UPDATE mytab SET 
name = CASE WHEN MOD(id, 2) = 0 THEN 'John Dow' ELSE 'Jane Doe' END,
email = CASE WHEN MOD(id, 2) = 0 THEN 'john@doe.com' ELSE 'jane@doe.com' END;

SELECT * FROM <dbname>.<table_name> WHERE username = "%Jane"
OR username = '%Doe%'
OR username = 'John%';

```
