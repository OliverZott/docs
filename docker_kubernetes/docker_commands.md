# Docker Commands & Examples

<https://www.youtube.com/channel/UC0NErq0RhP51iXx64ZmyVfg>
<https://www.udemy.com/course/docker-mastery/learn/lecture/32367182#overview>
<https://github.com/bretfisher/udemy-docker-mastery>

## Examples

Docker installation or *<https://labs.play-with-docker.com>*

### Example 1

```bash
docker version  # version history
clear  # clear terminal
docker run -d -p 8800:80 httpd  # -d detached -p port download apache image layers, create file systems and run in its own namespace
curl localhost:8800
```

### Example 2

```bash
# container
docker container run --publish 80:80 --detach --name webhost nginx  # 80 is default localhost port
curl localhost
docker container ls -a
curl localhost
docker container logs webhost
docker container top webhost
docker container stop <container id>
```

### Example 3

```bash
# Networks
docker container run -d --name nginx_1  nginx
docker network ls
docker network inspect bridge

docker network create skynet  # create network
docker container run -d --name nginx_2 --network skynet nginx
docker network inspect skynet

docker network connect skynet nginx_1  # connect container to network
docker container inspect nginx_1  # now on 2 networks

docker network disconnect skynet nginx_1  # disconnect container from network
```

## Docker Commands

- new version (management commands):
  - docker - command - subcommand
  - e.g. `docker container run`
- old version:
  - docker - command
  - e.g. `docker run`

```bash
# basic infos
clear 
curl localhost:8800
docker
docker version
docker info
ps aux  # inside container listing processes
```

```bash
# container
docker container run --publish 80:80 --detach --name webhost nginx  # 80 is default localhost port
docker container ls -a
curl localhost
docker container logs webhost
docker container stop <container id>
```

```bash
# contianer monitoring
docker container top <container id>  # process list in one container
docker container inspect <container id>  # details of one container config
docker container stats OPTIONAL:<container id>  # performance stats for all containers
```

```bash
# Shell inside container
docker container run -it --name proxy nginx bash  # -it interactive terminal
docker container exec -it mysql bash  # same as run, but on existing container. exec executes additional command in running container
docker container start -ai <container id>  # -a attach to container -i interactive
```

```bash
# Networking Concepts
docker container port <container id>  # show port mapping
docker container inspect --format '{{ .NetworkSettings.IPAddress }}' <container id>  # show ip address

# Networks CLI Concepts
docker network ls  # show networks
docker network inspect <network id>  # show network details
docker network create <network name>  # create network
docker network connect <network name> <container id>  # connect container to network
docker network disconnect <network name> <container id>  # disconnect container from network
```

```bash
```

```bash
```
