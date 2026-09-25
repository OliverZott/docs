# Docker Compose

Image Building

- `docker compose up`  ...Create and start containers (only builds if not already build)
- `docker compose build`  ...Build or rebuild services
- `docker compose up --build`  ...Build and start containers

- `docker compose ls`  ...List running compose projects
- `docker compose images`  ...List images used by the created containers
- `docker compose ps`  ...List containers
- `docker compose logs`  ...View output from containers
- `docker compose top`  ...Display the running processes

- `docker compose up -d`  ...Create and start containers in the background
- `docker compose pull`  ...Pull newer images
- `docker compose down`  ...Stop and remove containers and networks (`-v` also removes named volumes!)
