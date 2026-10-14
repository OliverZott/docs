# Environment Variables

> Linux shell specifics: see [linux/env-vars.md](linux/env-vars.md) · Docker secrets: see [docker03_secrets.md](docker%20and%20kubernetes/docker03_secrets.md)

## What they are

- A list of `KEY=value` strings that **every running process** gets from the OS when it starts
- That list is the process's **"environment"**
- Scope = **one process**: not a file, not truly global
- Read in code: `process.env.X` (Node), `os.environ["X"]` (Python), `Environment.GetEnvironmentVariable("X")` (.NET)

## Process & where the env lives

- **Program** = file on disk (`node.exe`), **process** = a running instance of it
- OS gives each process: **own private memory**, a **PID**, open files/sockets, and its **environment**
- Env = **plain text in the process's RAM**, not a file, not a stream:

```
PATH=/usr/bin\0HOME=/home/oliver\0DATABASE_NAME=aw\0
```

| | Storage |
|---|---|
| **Linux** | Kernel copies the strings on start (`execve`) to the top of the new process's stack; libc `environ` = list of pointers to them. Initial block visible in `/proc/<pid>/environ` |
| **Windows** | Block of `KEY=value\0` UTF-16 strings, ending with `\0\0`, in the **PEB** (Process Environment Block) |
| **Node** | `process.env` looks like an object, but reads/writes go through to that block |

→ Passing to a child = OS **copies these bytes** into the child's separate memory

## How they are passed: copy on start

```
Parent process (env: A=1, B=2)
 └─ starts child  →  child gets a COPY (A=1, B=2)
      └─ child sets C=3, changes A=9  →  parent still has A=1, no C
```

1. **Inherited downwards only**: a child gets a copy of its parent's env when it starts
2. **Snapshot**: later changes in the parent do not reach an already running child
3. **Never upwards**: a child can't change its parent's env
4. Hence: after changing a system variable, **restart the app** (terminal, VS Code, …) to see it

## Files are just sources

`.env`, `.bashrc`, the Windows dialog etc. do **not hold** live variables. Something **reads** them and puts the values into a process's env at start.

## Sources per system

| System | Where values come from | Who reads them / when |
|---|---|---|
| **Windows** | System + user variables (registry, *"Edit environment variables"* dialog, `setx`) | Explorer at login → every app started from it inherits |
| | `set X=1` (cmd), `$env:X = "1"` (PowerShell) | Current shell + its children only, gone when closed |
| **Linux / macOS** | `/etc/environment`, `/etc/profile`, `~/.profile`, `~/.bashrc`, `~/.zshrc` | Login / shell start (`source ~/.bashrc` to reload) |
| | `export X=1` | Current shell + its children |
| | `X=1 node app.js` | Only that one command |
| | systemd `Environment=` / `EnvironmentFile=` | Service start |
| **Docker image** | `ENV` in Dockerfile (**final stage only**, plus base image `ENV`) | Baked into the image, every container gets them |
| | `ARG` | Build time only, **not** in the running container |
| **Docker container** | Compose `environment:` / `env_file:`, `docker run -e` / `--env-file` | Container start (no rebuild needed) |
| | `HOSTNAME` | Set by Docker (container ID) unless `hostname:` is set |
| **App itself** | `dotenv` reads `.env` and adds to its **own** env | At runtime, does not overwrite existing vars by default |
| **CI (GitLab)** | CI/CD variables | Injected into the job's env |

## Docker Compose in detail

```yaml
services:
  aw-backend:
    environment:
      DATABASE_NAME: ${DATABASE_NAME}   # ← placeholder filled by Compose
    env_file: ./backend.env              # ← (optional) ALL keys injected into the container
```

1. **Auto `.env`**: Compose reads `.env` next to the compose file **only to fill `${VAR}` placeholders**
   - NOT copied into the container wholesale; a key gets there only if `environment:` references it
   - Shell env (incl. Windows variables) **overrides** `.env` values
   - Other file: `docker compose --env-file prod.env up`
2. **`env_file:`**: injects every key of that file into the container
3. Change a value → `docker compose up -d` recreates the container, **no rebuild**
4. Containers do **not** inherit the host's env, only what is explicitly given
5. Check what a container really has: `docker exec <container> env`

## Build time vs runtime

| | Build time (baked in) | Runtime (real env vars) |
|---|---|---|
| Example | Vite `VITE_*` written into the JS bundle | Backend `process.env.DATABASE_NAME` |
| Change needs | **New image** | Container restart / recreate |

- Frontend served by nginx: no Node process at runtime → `NODE_ENV` in compose does nothing
- Vite/React/Vue client vars end up as **plain text in the bundle**, never put secrets there

## Remarks

- `docker compose` (v2) vs old `docker-compose` (v1, EOL 2023): v1 kept quotes literally (`PW="abc"` → `"abc"`), v2 strips them
- Env vars are visible via `docker inspect` / `/proc/<pid>/environ`, so prefer Docker secrets (files) for passwords
