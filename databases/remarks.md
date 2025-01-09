# Database Basics

## Terminology

- Tuples
  - Definition: A tuple is essentially a row in a table. Each tuple represents a single record containing fields corresponding to the columns of the table.
  - Importance: Understanding tuples helps you grasp how data is structured and manipulated within a table.

- Transaction ID (XID)
  - Definition: A unique identifier assigned to each transaction in the database.
  - Importance: XIDs help track and manage transactions, ensuring data consistency and integrity. They are crucial for concurrency control and recovery.

- Frozen Transaction ID (relfrozenxid)
  - Definition: A special transaction ID assigned to tuples to indicate that they are immune to future transaction ID wraparound issues.
  - Importance: Freezing transactions prevents them from becoming obsolete as the transaction counter advances. It ensures that older tuples remain accessible and valid.

- Dead Tuples
  - Definition: Rows that have been deleted or updated and are no longer needed, but have not yet been physically removed from the table.
  - Importance: Dead tuples occupy space and can degrade performance. Removing them through vacuuming helps maintain efficient table size and performance.

- Index Scan
  - Definition: A process of scanning indexes to retrieve or modify data efficiently.
  - Importance: Index scans help speed up data retrieval and modification by avoiding full table scans, making operations more efficient.

- Page
  - Definition: A fixed-size block of storage used by PostgreSQL to store table and index data.
  - Importance: Pages are the basic units of storage and I/O. Managing pages efficiently helps optimize storage and access speed.

- Write-Ahead Logging (WAL)
  - Definition: A logging mechanism that ensures changes are recorded before they are applied, providing durability and crash recovery.
  - Importance: WAL helps ensure data consistency and integrity by providing a way to recover from crashes and other failures.

- Buffer
  - Definition: Memory used to temporarily store data while it is being processed.
  - Importance: Buffers help improve performance by reducing the need for disk I/O, allowing more efficient data access and manipulation.

- Cache Hit/Miss
  - Definition: A cache hit occurs when data is found in the buffer cache, while a cache miss occurs when data needs to be read from disk.
  - Importance: High cache hit rates improve performance by reducing disk access times, while cache misses can slow down operations.

- Vacuum
  - Definition: A maintenance process that removes dead tuples, reclaims storage, and updates statistics.
  - Importance: Regular vacuuming helps maintain database health, ensuring efficient space usage and accurate query planning.

## EXPLAIN, ANALYZE, VACUUM

- `EXPLAIN SELECT * FROM "Activities" WHERE "ActivityType" = 2;`
- `ANALYZE VERBOSE "Locations";`
- `VACUUM VERBOSE "Activities";`

## Databases

- Relational Databases
  - Description: Store data in tables with predefined schemas and relationships between them.
  - Examples: SQL Server, PostgreSQL, Oracle
  - Technical Details: Relational databases use structured query language (SQL) to manage and manipulate data. They enforce data integrity through constraints and support complex queries using joins. They are ACID-compliant, ensuring data consistency and reliability.
  - Advantages: Relational databases provide strong data consistency, support complex relationships, and have a mature ecosystem with extensive tooling and community support.
  - Disadvantages: They can be less flexible for handling unstructured or rapidly changing data, and scaling can be challenging for high-traffic applications.

- NoSQL Databases
  - Document Stores: Store data as documents, often in JSON or BSON format. Examples: MongoDB, CouchDB
    - Technical Details: Document stores store self-describing, semi-structured data as documents. They provide flexible schemas and allow nested data structures. They typically use query languages like MongoDB Query Language (MQL) or JavaScript Object Notation (JSON) queries.
    - Advantages: Document stores offer schema flexibility, horizontal scalability, and are well-suited for handling unstructured or rapidly changing data. They can handle large amounts of data and provide high availability.
    - Disadvantages: They may lack strong transactional support and can be less efficient for complex joins and aggregations.

  - Key-Value Stores: Store data as key-value pairs for fast retrieval. Examples: Redis, DynamoDB, Riak
    - Technical Details: Key-value stores store data as simple key-value pairs. They provide fast read and write operations and are often used for caching, session management, and real-time applications.
    - Advantages: Key-value stores offer high performance, scalability, and low latency. They are well-suited for use cases that require fast data access and high throughput.
    - Disadvantages: They lack complex querying capabilities and are limited to simple data retrieval based on keys.

  - Columnar Databases: Store data in columns instead of rows, optimized for analytical queries. Examples: Apache Cassandra, HBase
    - Technical Details: Columnar databases store data in a columnar format, which allows for efficient compression and selective column retrieval. They are designed for handling large volumes of data and performing analytical queries.
    - Advantages: Columnar databases provide fast query performance for analytical workloads, efficient storage, and horizontal scalability. They are suitable for applications that require real-time analytics and high write throughput.
    - Disadvantages: They may have limited support for transactional operations and can be complex to manage and optimize.

  - Graph Databases: Store data as graphs, managing entities and their relationships. Examples: Neo4j, Amazon Neptune
    - Technical Details: Graph databases represent data as nodes (entities) and edges (relationships). They provide efficient traversal and querying of complex relationships, making them suitable for applications that heavily rely on relationships.
    - Advantages: Graph databases excel at handling highly connected data, enabling efficient querying of complex relationships. They are well-suited for social networks, recommendation engines, and fraud detection systems.
    - Disadvantages: They may have limited support for complex aggregations and can be less performant for non-graph-related queries.

  - Time Series Databases: Optimized for handling time-stamped or time-series data. Examples: InfluxDB, TimescaleDB
    - Technical Details: Time series databases store and analyze data with timestamps, such as sensor data, financial data, or log data. They provide efficient storage, indexing, and querying of time-series data.
    - Advantages: Time series databases offer high write throughput, efficient storage, and specialized query capabilities for time-based analysis. They are suitable for monitoring, IoT, and real-time analytics.
    - Disadvantages: They may have limited support for complex relational queries and can be less suitable for general-purpose data storage.

  - Object-oriented Databases: Store data as objects used in object-oriented programming. Examples: ObjectDB, db4o
    - Technical Details: Object-oriented databases store data as objects, preserving the relationships and behavior defined in object-oriented programming. They provide transparent persistence and support complex data structures.
    - Advantages: Object-oriented databases offer seamless integration with object-oriented programming languages, support complex data models, and provide efficient object retrieval. They are suitable for object-oriented applications and domain-driven designs.
    - Disadvantages: They may have limited support for ad-hoc querying and can be less performant for large-scale data processing.

- Specialized Databases
  - In-Memory Databases: Store data primarily in memory for fast data retrieval. Examples: Redis, SAP HANA, Memcached
    - Technical Details: In-memory databases store data in memory for faster access compared to disk-based storage. They provide high read and write performance and are often used for caching, real-time analytics, and high-speed data processing.
    - Advantages: In-memory databases offer extremely fast data access, low latency, and high throughput. They are suitable for applications that require real-time data processing and low response times.
    - Disadvantages: They are limited by the available memory capacity and can be more expensive due to the need for large memory resources.

  - Vector Databases: Designed to store efficiently, index, and search high-dimensional vectors. Examples: FAISS, Annoy, Milvus, Pinecone
    - Technical Details: Vector databases specialize in storing and querying high-dimensional vectors, such as embeddings or feature vectors. They provide efficient similarity search and indexing algorithms for vector-based data.
    - Advantages: Vector databases offer fast similarity search, efficient indexing, and support for high-dimensional data. They are suitable for applications like recommendation systems, image search, and natural language processing.
    - Disadvantages: They may have limited support for non-vector data types and can be less suitable for general-purpose data storage.
