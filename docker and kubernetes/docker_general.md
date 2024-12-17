# Docker

- tool for defining and running multi-container Docker applications
- uses YAML files to configure the application's services `docker-compose.yml`
- all the containers are created in a single network
- to use V2 just use `docker compose` in cli!
- docker compose is talking to docker cli api in background

- perfect workflow:
  - `git clone repo`
  - `docker-compose up`

## Docker Compose (Image Building)

- `docker compose up`  ...Create and start containers (only builds if not already build)
- `docker compose build`  ...Build or rebuild services
- `docker compose up --build`  ...Build and start containers

- `docker compose ls`  ...List running compose projects
- `docker compose images`  ...List images used by the created containers
- `docker compose ps`  ...List containers
- `docker compose logs`  ...View output from containers
- `docker compose top`  ...Display the running processes

- `docker compose up -d`  ...Create and start containers in the background

## __Docker Concepts

- Why docker
  - Isolation
  - Envirnomnets
  - Speed (lifecycle)

- Image - registry - container ==> Build - Ship - Run
- client (cli command) vs server

### Image

A docker image is a read-only template with instructions for creating a Docker container. Is consist of layers and in includes everything needed to run an application: code, runtime, system tools, system libraries, file system and settings.

- contains of layers (depending on host os?!)

### Registry

- for docker image distribution

### Container

- A docker container is a running instance of an image.
- It's NOT just a small VM, it's just a process in dockers mini-linux-VM

### Networks

- Docker has default networks:
  - **bridge** for containers which is NATed behind host IP: `docker network ls` --> `bridge`
  - **host** less security, more performance

## __Dockerfiles

### EXPOSE

e.g. `EXPOSE 8080`

[Link](https://docs.docker.com/engine/reference/builder/#expose)

```txt
The EXPOSE instruction in a Dockerfile does not automatically publish the exposed port to the host machine. Instead, it serves as a form of documentation, indicating the ports that the container will listen on at runtime.

The EXPOSE instruction informs Docker that the container will listen on the specified port(s) and allows other containers to communicate with it on those ports. However, it does not make the container's ports accessible from the host machine or the outside world by default.
```

## Containers / Distros

### Alpine Linux

- small security-oriented, lightweight Linux distribution based on musl libc and busybox
- [Link](https://alpinelinux.org/)
