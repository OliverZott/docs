# DBMS - Training

- [additional material](https://www.rheinwerk-verlag.de/datenbanksysteme-das-umfassende-lehrbuch/)
- [additional material](https://www.rheinwerk-verlag.de/5841/)

## Chapter 1 - Introduction

 just a simple sql example

- **model** / **schema**  ...design of whole database

## Chapter 2 - Basics

- **dbms** vs **database**

### Relational Model

- **Records** must have PKs (UUID, AI, Natural Key...)
- NULL vs emptystring / 0

- **link tables** (e.g. for M:N relationships) ... more later
- **normal form**, **ER-diagram** ... more later
- 1-1 , 1-m, m-n relationships

### Transactions

- BEGIN, COMMIT, ROLLBACK

### ACID

- Atomicity ...all or nothing  (transaction logs)
- Consistency ... consistent before => consistent after
- Isolation ... locking for parallel transactionss --> queries can be parallel!!!! (CQRS)
- Durability ... once committed, data is safe (transaction logs)

## Chapter 3 - Database Modelling

### Schema and modelling steps

- Schema: 3 variants/steps
  - **conceptual** ...understanding the needs
  - **logical** ...ER-Model / ER-UML-diagram / null, PK, FK, relationships...
  - **physical** modelling ...dbms, tables, attributes, indizes, constraints...

- Advanced: **Views** and **Stored Procedures**

### modelling techniques
