# Secrets and Security

````yaml
secrets:
  jwt_secret:
    environment: JWT_SECRET   # ← HOST side: where the value is READ FROM

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
  - GItlab pipeline secrets

2. Inside the Container
  - Environment variables delivered to the container, accessible via `process.env` in Node.js or `os.environ` in Python
  - Secrets delivered as files, typically mounted under `/run/secrets/` or a custom path specified in the Docker Compose file
