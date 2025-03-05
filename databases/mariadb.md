# MariaDB

[B-Tree](https://en.wikipedia.org/wiki/B-tree)  
[InnoDB](https://en.wikipedia.org/wiki/InnoDB)

[Data Types](https://www.ionos.at/digitalguide/hosting/hosting-technik/mariadb-data-types/)

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

## Server Configurations

in `C:\Program Files\MariaDB 11.5\data\my.ini`
e.g. set collation and charecter set

```ini
collation-server = utf8mb4_unicode_ci
character-set-server = utf8mb4
```

## Comamnds (Examples)

- `mariadb -u root` ...login as root, no pw
- `SELECT USER(), CURRENT_ROLE();` ...check current user
- `SELECT User, Host FROM mysql.user;` ...view all users

### Databases

- `show databases;` ...**show**
- `create database tutorial character set='utf8mb4' collate='utf8mb4_general_ci' comment='sample db';` ...**create** a db using some setup params
- `select * from information_schema.schemata;` ...**information** about all databases (or schemata) in the MariaDB instance
- `alter database tutorial collate='utf8mb4_unicode_cli';` ...**alter** a database parameter
- `drop database tutorial` ...**drop**

### Table (keys - pk, fk)

- **create**

    ```sql
    create table employees (
        -> id int primary key auto_increment,
        -> employee_id int not null unique key,
        -> first_name varchar(30) not null,
        -> last_name varchar(30) not null,
        -> birth_date date);

    create departmens (
        -> id int not null primary key auto_increment,
        -> text varchar(50) not null
        -> );
    ```

- `describe employees;` ...**show**
- **alter** with **foreign keys**

    ```sql
    alter table employees
        -> add dept_id int not null,
        -> add constraint fk_dept_id
        -> foreign key (dept_id) references departments (id)
        -> on delete restrict
        -> on update restrict
        -> );
    ```

### Insert

- **auto-increment** field is filled by mariadb automatically.

- `insert into departments (text) values ('Research and Development');`
- `insert into employees (employee_id, first_name, last_name, birth_date, dept_id) values (412362, 'John', 'Doe', '1989-11-26', 1);`

### Load Data (csv)

```sql
LOAD DATA LOCAL INFILE 'C:\\repos\\docs\\databases\\sample_data\\maria_db_employee.csv'
    -> INTO TABLE employees
    -> FIELDS TERMINATED BY ','
    -> LINES TERMINATED BY '\r\n'
    -> IGNORE 1 LINES
    -> (id, employee_id, first_name, last_name, birth_date, dept_id);
```

### Select

- **where ... like ...**... `select last_name, first_name from employees where last_name like 'm%';`
- **where ... = ...** `select last_name, first_name from employees where dept_id = 1;`
- **order by**`select * from employees order by last_name;`
- **limit** `select * from employees limit 5;`

### Joins

- `` ...
- `` ...
