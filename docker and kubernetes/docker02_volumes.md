# Docker Volumes

Rule of thumb:

- Bind mount = "I need to touch these files from the host (or the host's backup does)."
- Named volume = "Docker should own this, I just need it to persist."
- External = "Compose must not create or delete this, it lives outside the project lifecycle."

**Which one is "best practice" depends on who runs the host:**

| Host | Use for persistent data |
| --- | --- |
| Own server / VM | Named volumes |
| Shared / managed hosting | Bind mounts to an agreed absolute path |
| Kubernetes | Persistent Volume Claims (PVC) |

## Bind Mounts

A bind mount maps a **real directory on the host** directly into the container.

- Short syntax auto-creates a missing host path (owned by root); long syntax with `create_host_path: false` fails instead
- Full transparency: you see the exact files on the host, backup with normal tools (`rsync`, `tar`)
- Hides the image's content at that path; host ownership applies (e.g. Postgres needs a dir writable by UID 999)
- Good for development, logs, and production data on shared hosting

### Example

```yaml
services:
  my-database:
    image: postgres:17
    volumes:
      - /srv/myapp/postgres:/var/lib/postgresql/data
```

## Named Volumes (Internal)

Named volumes are managed by Docker/Podman.
You do not choose the host path; the engine stores it under `/var/lib/docker/volumes/`.

- Created automatically when Compose starts
- An empty volume is first filled with the image's content at that path (incl. ownership)
- Good for production data on hosts you control; problematic on shared hosting (data outside your directory/backups, names global on the daemon)
- Deleted by `docker compose down -v`

```yaml
services:
  my-database: # service name (container name: <project>-my-database-1)
    image: postgres:17
    volumes:
      - my-data:/var/lib/postgresql/data #<source>:<target-inside-container>

volumes:
  my-data: # source-name used in service
    name: my-database # real volume name without project prefix (default: <project>_my-data) - global on the daemon!
```

### Named volume backed by a fixed host path

Hybrid: named in compose, but stored where you choose.

```yaml
volumes:
  my-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /srv/myapp/postgres # must exist
```

## Named Volumes (External)

External volumes are named volumes that must already exist.
Compose will not create or delete them.

- Must be created manually (`docker volume create ...`), otherwise `compose up` fails, e.g. on a fresh machine
- Safe from `docker compose down -v`, but NOT from `docker volume rm` / `docker volume prune -a`
- Use when the volume outlives the project: migrations, reusing existing data, sharing between projects

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
