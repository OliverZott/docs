# Install Docker and WSL2

- <https://docs.docker.com/desktop/windows/wsl/>

## WSL

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

## Docker

- <https://docs.docker.com/desktop/windows/wsl/>
- docker error message `docker-users`
  - [Link](https://icij.gitbook.io/datashare/faq-errors/you-are-not-allowed-to-use-docker-you-must-be-in-the-docker-users-group-.-what-should-i-do)

-

## VS Code Linux DevEnv

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

# Commands

- `docker run Docker run` [doc](https://docs.docker.com/engine/reference/run/)
- `docker cp` [doc](https://docs.docker.com/engine/reference/commandline/cp/)
- `docker build` [doc](https://docs.docker.com/engine/reference/commandline/build/)
- `docker run -d -p 80:80 docker/getting-started` [tut](http://localhost/tutorial/)

# Examples

With running Docker Desktop App `http://localhost/tutorial/`

# ProjectService

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
