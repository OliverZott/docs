# MongoDB

## Course & Rersources

- [Udemy Course](https://www.udemy.com/course/mongodb-with-spring-boot-spring-data-mongorepository-mlab-cloudfoundry/learn/lecture/18329460#announcements)

- <https://medium.com/stackfame/run-mongodb-as-a-service-in-windows-b0acd3a4b712#:~:text=To%20start%20MongoDB%2C%20run%20mongod,connections%20message%20in%20the%20console>.

### Terms: SQL  ->   Mongo

- Database => Database
- Table => Collection
- Column => Field
- Row => Document
- Foreign Key => Sub Document (Reference)

# Prerequisites

- **Installation**
  - `choco install mongodb` or manually form [Link](https://www.mongodb.com/try/download/community?tck=docs_server)
  - `choco install mongodb-shell`  ?
  - `choco install mongodb-compass` GUI
- **Data folder**
  - Default: `ProgramData\MongoDB\data\db`
  - Create data folder: `md c:\data\db`
  - Set folder as data folder `.\mongod.exe --dbpath "C:\data"` inside `C:\Program Files\MongoDB\Server\5.2\bin`
- **Start** mongodb:
  - `mongod.exe` or `C:\Program Files\MongoDB\Server\5.2\bin\mongod.exe`
  - Shell: `mongosh`  (in Path by choco install)

## CLI commands

- <https://www.mongodb.com/docs/manual/reference/mongo-shell/>
- <https://tecadmin.net/tutorial/mongodb/mongo-shell/>

```bash
mongosh
show dbs
use <dbname>
show collections
db.getCollectionInfos();
db.hotels.find()
db.hotels.find({"Name":"HotelOne"})
```
