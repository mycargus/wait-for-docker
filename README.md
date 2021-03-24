[![Build Status](https://travis-ci.com/mycargus/wait-for-docker.svg?branch=master)](https://travis-ci.com/mycargus/wait-for-docker)

# wait-for-docker

A slim and simple [docker] container that uses netcat to determine whether other
docker containers are ready to accept incoming connections.

## Usage

Spin up your container(s) and then use the `wait-for` docker container to wait
for those container(s) to accept incoming connections on a specified port.

For example:

```sh
docker network create example-network
docker run -d --network example-network -p 5432:5432 --name postgres postgres:latest
docker run -d --network example-network -p 80:80 --name web mycargus/hello_docker_world:master
docker run --rm --network example-network mycargus/wait-for:master \
  postgres:5432 web:80
```

Or with docker-compose (it creates a network for you):

```yaml
# docker-compose.yml
---
version: '3.7'

services:
  wait-for:
    image: mycargus/wait-for:master

  web:
    command: "bash -c 'sleep 10 && ruby hello.rb -p 8080'"
    image: mycargus/hello_docker_world:master
    ports:
      - '8080:8080'
```

```bash
docker-compose up -d web
docker-compose run --rm wait-for web:8080
```

You can customize `wait-for` according to your needs with environment variables
such as `WAIT_ATTEMPTS` and `WAIT_INTERVAL`. See `bin/wait-for` for details.

## Roadmap

- [x] add YAML linter
- [x] add Dockerfile linter
- [x] add git pre-commit hooks
- [ ] add more tests

## Contributing

We welcome and encourage contributions! See our [Contributing] doc for
development instructions and more info.

## License

MIT. See LICENSE for details.

[contributing]:
  https://github.com/mycargus/wait-for-docker/blob/master/CONTRIBUTING.md
[docker]: https://docs.docker.com/
