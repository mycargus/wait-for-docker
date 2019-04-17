#!/usr/bin/env bash

# Build and push the docker image to docker hub registry

set -ev

docker build -t mycargus/wait-for:latest .

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push mycargus/wait-for:latest
