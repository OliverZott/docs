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

### Feature services / Service Layer (e.g. WeightDataService)

- catch exceptions (ApiExceptions, Network exceptions... )
- log domain-specific messages
- return fallback values (empty list, null, false)
- service layer returns a result object, not an exception

## ViewModel

- NO exception handling NO try/catch
- NO logging of infrastructure errors
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
