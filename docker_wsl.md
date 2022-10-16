# Docker

- <https://docs.docker.com/desktop/windows/wsl/>

## Prerequisites / Installation

### WSL2 (Windows)

- <https://docs.microsoft.com/en-us/windows/wsl/install>

- `Turn Windows Features OnOff`
  - *Virtual Machine Platform*
  - *Windows Subsystem For Linux*
- `Install distribution`
  - via Store
  - `wsl -l -v`
  - `wsl --list --online`
  - `wsl --install -d <DistroName>`
  - `wsl -l -v`
- Kernel Update
  - <https://docs.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package>

### VS Code Linux DevEnv

- <https://docs.microsoft.com/en-us/windows/wsl/setup/environment>
- <https://code.visualstudio.com/api/advanced-topics/remote-extensions#architecture-and-extension-types>
- install linux distro
- vs code plugin: <https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack>
- weget
  - <https://wiki.ubuntuusers.de/wget/>
- g++ compiler: sudo apt install build-essential
  - `sudo apt install build-essential`
  - g++ flags: <https://www.rapidtables.com/code/linux/gcc/gcc-o.html#output%20file>

### Resources

- [WSL2](https://www.youtube.com/watch?v=5RQbdMn04Oc)
- [WSL2](https://www.youtube.com/watch?v=A0eqZujVfYU)
- [Docker](https://www.youtube.com/watch?v=0oEsMwSxBsk)
- [Docker](https://www.youtube.com/watch?v=WcQ3-M4-jik)

## ERRORS

- docker error message `docker-users`
  - [Link](https://icij.gitbook.io/datashare/faq-errors/you-are-not-allowed-to-use-docker-you-must-be-in-the-docker-users-group-.-what-should-i-do)

# Commands - Basic

- `docker image ls`
- `docker  ps` = `docker container ls`
- `docker ps -a` ...show all (also not running)
- `docker run name/id`  [doc](https://docs.docker.com/engine/reference/run/)
- `docker stop name/id`

- Copy / Build
  - `docker cp` [doc](https://docs.docker.com/engine/reference/commandline/cp/)
  - `docker build` [doc](https://docs.docker.com/engine/reference/commandline/build/)

- Compose
  - `docker-compose up --build`
    - up ... for syncing and server start
    - --build ... to build container the first time

- Remove container and image (remove container before image)
  - `docker container rm name/id` or `docker rm name/id`
  - `docker image rm name/id` or `docker rmi name/id`

- Stop all containers:
  - `docker container ls -aq` ... generates list of all containers
  - `docker container stop $(docker container ls -aq)`

## Flags

- `-a` or `--attach` ... Attach STDOUT/STDERR and forward signals
- `-p` ... Publish all exposed ports to the host interfaces   `host:container`
- `-d` ...  run the container in the background in a “detached” mode
- `--rm` ... Automatically remove the container when it exits
- `-it` ... interactive mode
- `--name` ... Assign a name to the container

# Commands - Container

## Example

- `docker run --rm -d -p 15672:15672 -p 5672:5672 --name my_rabbit rabbitmq:3-management`

## Tags

- look up at <https://hub.docker.com>
- `docker run redis:latest`

## Inputs

- container runs in **non-interactive** mode.
- `docker run -it kodekloud/simple-prompt-docker`  ... **-it** for interactive Input and Terminal output from container.

## Attach

To attach to running container in  background:

- `docker run -d ubuntu sleep 5000`  ... **-d** for background
- `docker attach <id/name>`

## Exec

To run command in running container

- `docker exec <contianer_name/id> env` ... to see environment variables

## Port Mapping

**-p**

- check port: `docker run kodekloud/simple-webapp` --> e.g. " port 8080"
- `docker run -p 80:8080 kodekloud/simple-webapp` ... host / container
- check browser: `localhost:80`

## Volume Mapping

**-v**

Docker container has own isolated file-system. When container is removed--> files lost.  To persist data, map to outside Host directory.

- `docker run -v /host/dir/path:/container/dir/path mysql` ... host / container

## Inspect / Log Container

- `docker inspect <id//name>`
- `docker logs`

# Examples

## Python Example

- <https://github.com/OliverZott/python-training/tree/master/youtube-arjancodes/docker-usage>
  - `docker run -d -p 80:80 docker/getting-started` [tut](http://localhost/tutorial/)

- <https://github.com/OliverZott/docker-examples>

With running Docker Desktop App `http://localhost/tutorial/`

## ProjectService

1. WSL & Docker install
1. Clone repo & steps from wiki
1. VS 2022
    - Startup project `docker-compose` and try **build**
    - If error: `dotnet tool list -g` and `dotnet tool install --global dotnet-ef --version 6.0.6`
    - Execution Policy: `Get-ExecutionPolicy` and `Set-ExecutionPolicy RemoteSigned`

after successfull build:

- Docker: two images
  - trinitycontainers.azurecr.io/projectservice
  - postgres
- Docker: Multi-Container
- Postgresql CLI from docker
  - `psql projectservice projectservice` (see docker-compose.yml file in repo)
  - `\l` ... list available databases
  - `\d` or `\dt`... list available tables
  - `\d "FeatureServices"` ...
  - `exit` and `exit` ... to exit :)
