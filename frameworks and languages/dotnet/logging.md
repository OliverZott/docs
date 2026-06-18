# Logging General Ideas

## Frontend example (MAUI app)

### ApiClient

- no logging, ApiClient should NOT use try/catch
- ApiClient should throw custom ApiExceptions

    ```cs
  if (!response.IsSuccessStatusCode)
    throw new ApiException(...);
    ```

- no token logic
- no UI logic
- no domain logic
- only transport + JSON

ApiClient is intentionally “dumb.” It’s a raw pipe to the backend.

### Feature services / Service Layer (e.g. WeightDataService)

- catch exceptions (ApiExceptions, Network exceptions... )
- log domain-specific messages
- return fallback values (empty list, null, false)

### ViewModel

- Receives result objects
- Updates UI
- No try/catch/excption handling
- No logging of infrastructure errors
- No infrastructure knowledge
- ONLY handles result objects

### Global exception handlers

- catch anything that escapes
- log fatal errors
- optionally show alerts (your current pattern)

### Advantages of this approach

- clean separation
- readable logs
- maintainable code
- minimal boilerplate
