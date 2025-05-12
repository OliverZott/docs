# Authentication & Authorization

- **Authentication** ...user identity
- **Authorization** ...what can user do
- **RBAC** ...role based access control

- **Cookies**: Best for simpler, server-side applications where server control over sessions is important.
- **JWTs**: Best for scalable, distributed systems and microservices architectures.

## JWT

JWTs are stateless tokens that contain user information encoded in a JSON object. Stateless because server doesn't have to look up session and reference server-side state!

How They Work:

- Login: When a user logs in, the server generates a JWT, which includes user information and a signature.
- Client Storage: The client stores the JWT (usually in localStorage or sessionStorage) and includes it in the header of every subsequent HTTP request.
- Server Validation: The server validates the JWT using a secret key but does not store it.

Pros:

- Stateless: No server-side session storage is needed.
- Scalability: Suitable for microservice architectures and distributed systems.
- Self-Contained: Carries user information within the token, reducing database lookups.

Cons:

- Token Storage: Tokens need to be securely stored on the client side.
- Token Revocation: Revoking tokens can be more complex compared to cookies.

Ideal Use Cases:

- Serverless and distributed systems.
- Applications that require scalability and cross-service authentication.

## Cookies

Cookies are small pieces of data stored on the client's browser. They are used to maintain state between the client and the server1.

Technically, you could use cookies in a more stateless manner by storing all the necessary user information within the cookie itself. This approach is similar to how JWTs work.

How They Work:

- Login: When a user logs in, the server creates a session and stores the session data (like user ID, roles, etc.) in memory or a database. The server then sends a session ID back to the client as a cookie.
- Subsequent Requests: The client sends the cookie with every HTTP request, allowing the server to identify the user by looking up the session ID.
- Session Lookup: On each request, the server looks up the session ID from the cookie and retrieves the corresponding session data from its storage to identify the user.

Pros:

- Simplicity: Easy to implement for server-side applications.
- Server Control: Sessions can be easily revoked by clearing the session on the server.
- Fine-Grained Control: More control over session management.

Cons:

- Server Storage: Requires server-side storage for session management (e.g., Redis, database).
- Scalability Issues: Not ideal for scaling in distributed systems because session data is stored on one server.
- CSRF Vulnerability: Vulnerable to Cross-Site Request Forgery (CSRF) attacks if not handled correctly.

Ideal Use Cases:

- Monolithic applications or applications where the frontend and backend are tightly coupled.
- Applications where server-side control over sessions is essential, such as banking applications.
