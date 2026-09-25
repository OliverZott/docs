# Docker

## Docker Compose

- tool for defining and running multi-container Docker applications
- uses YAML files to configure the application's services `docker-compose.yml`
- by default all containers of a project share one network (more can be defined)
- to use V2 just use `docker compose` in cli!
- docker compose is talking to docker cli api in background

- workflow example:
  - `git clone repo`
  - `docker compose up`

## Docker Concepts

- Why docker
  - Isolation
  - Envirnomnets
  - Speed (lifecycle)

- Image - registry - container ==> Build - Ship - Run
- client (cli command) vs server

### Image

A docker image is a read-only template with instructions for creating a Docker container. Is consist of layers and in includes everything needed to run an application: code, runtime, system tools, system libraries, file system and settings.

- contains of layers, built for a specific OS/architecture (e.g. `linux/amd64`, `linux/arm64`); uses the host kernel

### Registry

- for docker image distribution

### Container

- A docker container is a running instance of an image.
- It's NOT a small VM, it's an isolated process (namespaces, cgroups) on the host kernel
- only Docker Desktop (Windows/Mac) runs it inside a small Linux VM

### Networks

- Docker has default networks:
  - **bridge** for containers which is NATed behind host IP: `docker network ls` --> `bridge`
  - **host** less security, more performance
  - **none** no networking
- user-defined networks (incl. compose default) resolve containers by service name, default `bridge` does not

## Dockerfiles

### EXPOSE

e.g. `EXPOSE 8080`

[Link](https://docs.docker.com/engine/reference/builder/#expose)

```txt
The EXPOSE instruction in a Dockerfile does not automatically publish the exposed port to the host machine. Instead, it serves as a form of documentation, indicating the ports that the container will listen on at runtime.

```

- Containers on the same network can reach **every** listening port, with or without `EXPOSE` or `ports:`
- `EXPOSE` is documentation (+ used by `docker run -P`); `ports:` only publishes to the host

## Containers / Distros

### Alpine Linux

- small security-oriented, lightweight Linux distribution based on musl libc and busybox
- [Link](https://alpinelinux.org/)
