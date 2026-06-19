# API Operation Standards (Lauret – The Design of Web APIs)

Summary of book:

- `The Design of Web APIs` by `ARNAUD LAURET`
- https://www.amazon.com/Design-Web-APIs-Second-dp-1633438147/dp/1633438147

## References (book pages)

- Success feedback → Ch. 5.2.5 (approx. p. 128)
- Error feedback (404 rules) → Ch. 5.2.3 (approx. p. 122)
- Collections must always return arrays → Ch. 7.1.2 (approx. p. 167)
- Status code selection summary → Ch. 8.4.3 (approx. p. 209)

---

## POST (create)

### item

- 201 Created — created successfully (Ch. 5.2.5)
- 201 Created — Location header only (Ch. 5.2.5)
- 400 Bad Request — invalid input (Ch. 5.2.3)
- 404 Not Found — parent missing (Ch. 5.2.3)

### collection

- (POST targets a collection to create an item)

---

## GET (retrieve)

### item

- 200 OK — item exists (Ch. 5.2.5)
- 204 No Content — item missing but parent exists (Ch. 5.2.5)
- 404 Not Found — parent missing (Ch. 5.2.3)

### collection

- 200 OK — items exist, array (Ch. 7.1.2)
- 200 OK — empty array [] (Ch. 7.1.2)
- 404 Not Found — collection/parent missing (Ch. 5.2.3)

---

## PUT (update)

### item

- 200 OK — updated successfully (Ch. 5.2.5)
- 204 No Content — updated, no body (Ch. 5.2.5)
- 201 Created — created via PUT (optional) (Ch. 5.2.5)
- 404 Not Found — item or parent missing (Ch. 5.2.3)
- 400 Bad Request — invalid input (Ch. 5.2.3)

### collection

- 200 OK — collection updated
- 204 No Content — updated, no body
- 400 Bad Request — invalid input
- 404 Not Found — collection missing

---

## DELETE (delete)

### item

- 204 No Content — deleted successfully (Ch. 5.2.5)
- 404 Not Found — item or parent missing (Ch. 5.2.3)

### collection

- 204 No Content — deleted successfully
- 404 Not Found — collection missing
