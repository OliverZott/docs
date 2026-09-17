# Docker Volumes

Rule of thumb:

- Bind mount = "I need to touch these files from the host."
- Named volume = "Docker should own this, I just need it to persist."
- External = "...and nobody should be able to delete it by mistake."

## Bind Mounts

A bind mount maps a **real directory on the host** directly into the container.

- Host path must exist (`./data`, `/srv/db`, etc.)
- Full transparency: you see the exact files on the host
- Permissions matter
- Ideal for development or logs you want to inspect
- Defined only in **docker-compose.yml**

### Example

```yaml
services:
  my-database:
    image: postgres:17
    volumes:
      - ./data:/var/lib/postgresql/data
```

## Named Volumes (Internal)

Named volumes are managed by Docker/Podman.
You do not choose the host path; the engine stores it internally.

- Created automatically when Compose starts
- Engine handles permissions
- Good for production databases
- Deleted by docker compose down -v
- Defined in docker-compose.yml

```yaml
services:
  my-database: # service name (container-name smth like <project>_my-database_1)
    image: postgres:17
    volumes:
      - my-data:/var/lib/postgresql/data #<source>:<target-inside-container>

volumes:
  my-data: # source-name used in service
    name: my-database # renames volume object - 'docker volume ls'
```

## Named Volumes (External)

External volumes are named volumes that must already exist.
Compose will not create or delete them.

- Must be created manually (docker volume create ...)
- Safe from accidental deletion
- Ideal for critical production data
- Defined in docker-compose.yml

```yaml
services:
  my-database:
    image: postgres:17
    volumes:
      - my-data:/var/lib/postgresql/data

volumes:
  my-data:
    external: true
    name: my-database
```
