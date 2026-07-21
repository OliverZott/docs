# API Naming & Routing Standards (Lauret – The Design of Web APIs)

Summary of book:

- `The Design of Web APIs` by `ARNAUD LAURET`
- https://www.amazon.com/Design-Web-APIs-Second-dp-1633438147/dp/1633438147

## References (book pages)

- Resource naming rules → Ch. 4.2.1 (approx. p. 86–90)
- Collection vs. item naming → Ch. 4.2.2 (approx. p. 91–94)
- Path structure & hierarchy → Ch. 4.3.1 (approx. p. 96–101)
- Query parameters vs. path parameters → Ch. 4.3.2 (approx. p. 102–105)
- Versioning (URL vs. header) → Ch. 9.2.1 (approx. p. 228–233)
- Consistency & predictability → Ch. 7.1.2 (approx. p. 167)

---

# Naming Conventions & Routing

## Resource Naming (Ch. 4.2.1)

- Use nouns, not verbs
- Use lowercase
- Use plural nouns for collections
- Use singular nouns only for item endpoints via `{id}`
- Avoid action words in paths

### Examples

- `/api/books`
- `/api/books/{id}`
- `/api/patients/{id}/measurements`

---

## Path Structure (Ch. 4.3.1)

- Use hierarchical paths to express containment
- Parent → child → sub‑resource
- Do not encode actions in the path
- Do not use verbs in the path

### Good

- `/api/books/{id}`
- `/api/patients/{id}/appointments`
- `/api/patients/{id}/measurements/weight`

### Bad

- `/api/getBook/{id}`
- `/api/bookById/{id}`
- `/api/patient/{id}/getMeasurements`

---

## Collection vs. Item (Ch. 4.2.2)

### Collection

- `/api/books`
- Always plural
- Returns array

### Item

- `/api/books/{id}`
- `{id}` identifies a single resource

---

## Query Parameters vs. Path Parameters (Ch. 4.3.2)

- Use **path parameters** for identifying a specific resource
- Use **query parameters** for filtering, searching, sorting

### Good

- `/api/books/{id}`
- `/api/books?name=foo`
- `/api/books?author=bar&year=2020`

### Bad

- `/api/book?name={id}` (wrong use of query for identity)
- `/api/{id}/book/` (ambiguous parent)

---

## Versioning (Ch. 9.2.1)

- Prefer **header‑based versioning**
- URL versioning is acceptable but less ideal
- If using URL versioning, place version at the root

### Good

- `/v1/books/{id}`
- `/v2/patients/{id}/measurements`

### Bad

- `/api/v1/books/{id}`
- `/v1/api/books/{id}` (redundant)
- `/api/books/v1/{id}` (version in the wrong place)

---

# Summary of Example Routes

## Valid

- `/api/books/{id}`
- `/api/books`
- `/api/patients/{id}/measurements`
- `/api/patients/{id}/measurements/weight`
- `/v1/books/{id}`

## Invalid

- `/api/{id}/book/`
- `/api/bookS/{id}` (wrong pluralization)
- `/api/book?name={id}` (wrong use of query)
- `/v1/api/book/{id}` (redundant prefix)
- `/api/book/get/{id}` (verb in path)
