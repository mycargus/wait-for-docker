#!/usr/bin/env bash

# Build and push the docker image to docker hub registry

set -ev

(echo "${DOCKER_PASSWORD}" | docker login --username="mycargus" --password-stdin) || \
  (echo "Docker login failed!" && exit 1)

docker build . \
  --tag mycargus/wait-for:latest \
  --tag mycargus/wait-for:master

docker push mycargus/wait-for:latest
docker push mycargus/wait-for:master
