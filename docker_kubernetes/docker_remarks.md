# Dockerfile

## Keywords

### Container

- A docker container is a running instance of an image.
- It's NOT just a small VM, it's just a process in dockers mini-linux-VM

### Image

A docker image is a read-only template with instructions for creating a Docker container. Is consist of layers and in includes everything needed to run an application: code, runtime, system tools, system libraries, file system and settings.

### EXPOSE

e.g. `EXPOSE 8080`

[Link](https://docs.docker.com/engine/reference/builder/#expose)

````txt
The EXPOSE instruction in a Dockerfile does not automatically publish the exposed port to the host machine. Instead, it serves as a form of documentation, indicating the ports that the container will listen on at runtime.

The EXPOSE instruction informs Docker that the container will listen on the specified port(s) and allows other containers to communicate with it on those ports. However, it does not make the container's ports accessible from the host machine or the outside world by default.
```
