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
docker image ls && docker container ls -a && docker network ls && docker volume ls
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
# Networks / DNS resolution by namespace
docker container run -d --name nginx_1  nginx:alpine
docker network ls
docker network inspect bridge

docker network create skynet  # create network
docker container run -d --name nginx_2 --network skynet nginx:alpine
docker network inspect skynet

docker network connect skynet nginx_1  # connect container to network
docker container inspect nginx_1  # now on 2 networks

docker container exec -it nginx_1 ping nginx_2  # can ping without knowing IP - DNS resolution by namespace/hostnames

docker network disconnect skynet nginx_1  # disconnect container from network
```

### Example 4

```bash
# Images & Layers
docker image ls  # list images
docker image tag nginx test/nginx
docker login  # docker logout if necessary
docker push test/nginx  # mot working - not logged in
```

### Example 5

```bash
# Volumes
docker container run -d --name mysql-container -e MYSQL_ALLOW_EMPTY_PASSWORD=True -v mysql-db:/var/lib/mysql mysql # -v named volume, everything in fron of ":" is volume name
docker container inspect mysql-container
docker volume inspect mysql-db

docker container run -d --name my_pg1 -e POSTGRES_PASSWORD=mysecretpassword -v psql-data:/var/lib/postgresql/data postgres:9.6.1-alpine

# Bind Mounting
docker container run -d --name nginx -p 80:80 -v $(pwd):/usr/share/nginx/html nginx  # in current sample directory (windows: ${pwd})
touch test.txt
echo "hello there" > test.txt
docker container exec -it nginx bash # in 2nd terminal window ...go to 
cd /usr/share/nginx/html 
cat test.txt
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
# container monitoring
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
# Images & Layers
docker image ls  # list images
docker image history <image id>  # show layers of changes made in image
docker image inspect <image id>  # show details of image

# tags and push to docker hub
docker image tag <image id> <new image name>  # tag image
```

```bash
# Clean Up
docker image prune  # clean dangling images
docker image prune -a  # clean all unused images
docker system prune
docker volume prune
docker system df
docker network  prune
```

## Custom docker command

- add the following to `~/.bashrc` or `~/.bash_profile`
- then restart terminal or `source ~/.bashrc` or `source ~/.bash_profile`

```bash
alias dockerstuff='echo "DOCKER IMAGES" && echo "----------------------------------" && docker image ls && echo "DOCKER CONTAINERS" && echo "----------------------------------" && docker container ls -a && echo "DOCKER NETWORKS" && echo "----------------------------------" && docker network ls && echo "DOCKER VOLUMES" && echo "----------------------------------" && docker volume ls'
```
