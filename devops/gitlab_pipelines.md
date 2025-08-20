# Gitlab

**GitLab Runner**: The application that executes CI/CD jobs from GitLab pipelines on a target computing platform.

**Runner**: A configured instance of GitLab Runner that can execute jobs. Depending on the type of executor, this machine could be local to the runner manager (shell or docker executor) or a remote machine created by an autoscaler (docker-autoscaler or kubernetes).

**Runner manager**: The process that reads the config.toml file and runs all the runner configurations and job executions concurrently.

**Executor**: The method GitLab Runner uses to execute jobs (Docker, Shell, Kubernetes, etc.).

- docker executor -> each job is run in a separat container
- shell executor -> job runs on the host (bare metal / VM)
- ssh executor -> Job runs via SSH on a remote host

**Pipeline**: A collection of jobs that run automatically when code is pushed to GitLab.

**Job**: A single task in a pipeline, such as running tests or building an application.

```txt
[Host / VM / Bare Metal]
        │
        └── GitLab Runner (evtl. selbst als Docker-Container)
                │
                ├── Job-Container (für jeden Job ein neuer)
                │       └── Docker CLI (z. B. `docker build`)
                │
                └── dind-Service-Container (Docker Daemon)
                        └── Führt Docker-Befehle aus, z. B. `build`, `push`
```

## Runners

[runner execution flow](https://docs.gitlab.com/runner/#runner-execution-flow)

Runners are the agents that run the GitLab Runner application, to execute GitLab CI/CD jobs in a pipeline.
They are responsible for running your builds, tests, deployments, and other CI/CD tasks defined in `.gitlab-ci.yml` files.

Workflow of how runners work:

- A runner must first be registered with GitLab, which establishes a persistent connection between the runner and GitLab.
- When a pipeline is triggered, GitLab makes the jobs available to the registered runners.
- Matching runners pick up jobs, one job per runner, and execute them.
- Results are reported back to GitLab in real-time.

### workflow

- **GitLab Runner Container**
  - Runs on the Host (z. B. einem Server oder VM)
  - Handles pipelines executions
  - uses `Docker Executor` to run jobs in containers

- **Job Container**
  - created by runner for each job
  - has the `docker CLI` (So the job container can *talk* Docker, but it can't *do* Docker on its own)
  - Executes .gitlab-ci.yml script
  - has access to env-varsiables, project folder etc

- `docker:dind` Service Container
  - gets started parallel to Job-Container
  - provides the `Docker Daemon` (dockerd)
  - Job-Container communicates via DOCKER_HOST=tcp://docker:2375 with that Daemon
  - So the Job can execute docker build, docker push, etc.
