# Docker Compose - Remarks

- tool for defining and running multi-container Docker applications
- uses YAML files to configure the application's services `docker-compose.yml`
- all the containers are created in a single network
- to use V2 just use `docker compose` in cli!
- docker compose is talking to docker cli api in background

## CLI

- not production-grade tool but nice for local dev & test
- most important commands:
  - `docker-compose up` - start containers and setup volumes/networks
  - `docker-compose down` - stop containers and remove containers/volumes/networks
- perfect workflow:
  - `git clone repo`
  - `docker-compose up`
