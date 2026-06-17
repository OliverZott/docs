# Logging General Ideas

## Frontend example (MAUI app)

### ApiClient

- no logging
- no token logic
- no UI logic
- no domain logic
- only transport + JSON

ApiClient is intentionally “dumb.” It’s a raw pipe to the backend.

### Feature services (e.g. WeightDataService)

- catch exceptions
- log domain-specific messages
- return fallback values (empty list, null, false)

### ViewModel

- Receives result objects
- Updates UI
- No try/catch
- No logging
- No infrastructure knowledge

### Global exception handlers

- catch anything that escapes
- log fatal errors
- optionally show alerts (your current pattern)

### Advantages of this approach

- clean separation
- readable logs
- maintainable code
- minimal boilerplate
