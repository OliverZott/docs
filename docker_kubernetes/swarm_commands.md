# Docker Swarm

## Commands

- `docker swarm init` - Initialize a swarm
- `docker swarm --help`
- `docker node --help`
- `docker service --help`  ... replaces `docker run` command

## Examples

- `docker service create alpine ping 8.8.8.8`
- `docker service ls`  ... list services
- `docker service ps <service_id>` ... list tasks of a service
- `docker service update <service_id> --replicas 3` ... scale service to 3 replicas
- `docker container ls`
- `docker container rm <container_id>`  delete one container
- `docker service ps <service_id>`
- `docker service rm <service_id>` ... remove service

### Example 1

- `docker network create --driver overlay mydrupal`  --driver overlay creates a network that spans all nodes in the swarm
- `docker service create --name psql --network mydrupal -e POSTGRES_PASSWORD=mypass postgres:14`
- `docker service create --name drupal --network mydrupal -p 80:80 drupal:9`
- `docker network ls` and `docker service ls` and `docker service ps <serviceid>`
- localhost:80 --> postgres postgres mypass host=psql  (service name, works because overlay network)
