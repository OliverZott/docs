# Docker Secrets

```yaml
secrets:
  jwt_secret:
    environment: JWT_SECRET   # ← HOST side: where the value is READ FROM (Compose >= 2.23, .env works)
  other_secret:
    file: ./secrets/other.txt # ← alternative source: a file on the host

services:
  aw-backend:
    environment:              # ← CONTAINER side: delivered AS env vars
      DATABASE_HOST: aw-database
    secrets:                  # ← CONTAINER side: delivered AS files
      - jwt_secret
```

1. Origin of Secrets

   - Environment variables on the host machine, such as `JWT_SECRET`, which are read by Docker to create secrets
   - env files on the host machine, which are read by Docker to create secrets / files inside container
   - GitLab pipeline secrets (end up as one of the above on the host)

2. Inside the Container

   - Environment variables delivered to the container, accessible via `process.env` in Node.js or `os.environ` in Python
   - Secrets delivered as files, typically mounted under `/run/secrets/` or a custom path specified in the Docker Compose file

3. Security

   - Without Swarm, secrets are plain read-only bind-mounted files, not encrypted
   - Advantage over env vars: not visible in `docker inspect` or the process environment
