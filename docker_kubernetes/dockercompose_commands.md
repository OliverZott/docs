# Docker Compose - Commands

## CLI commands

- `docker compose ls`  ...List running compose projects
- `docker compose images`  ...List images used by the created containers
- `docker compose ps`  ...List containers
- `docker compose logs`  ...View output from containers
- `docker compose top`  ...Display the running processes

- `docker compose up -d`  ...Create and start containers in the background

## Image Building

- `docker compose up`  ...Create and start containers (only builds if not already build)
- `docker compose build`  ...Build or rebuild services
- `docker compose up --build`  ...Build and start containers
