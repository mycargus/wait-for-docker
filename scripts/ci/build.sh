#!/usr/bin/env bash

set -ev

export COMPOSE_FILE=docker-compose.yml

function cleanup()
{
  exit_code=$?

  echo ":: Cleaning up"

  docker-compose kill
  docker-compose rm -fv

  if [[ "${exit_code}" == "0" ]]; then
    echo ":: It's working!"
  else
    echo ":: Build Failed :("
  fi

  exit $exit_code
}

trap cleanup INT TERM EXIT

docker-compose pull
docker-compose build --pull
docker-compose up -d web

docker-compose run --rm wait-for web:8080
