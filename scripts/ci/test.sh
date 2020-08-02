#!/usr/bin/env bash

set -ev

docker-compose build --pull
docker-compose pull

docker-compose up -d web

docker-compose run --rm wait-for web:8080 && echo $?

exit_code=$?
echo "wait-for container exited with: ${exit_code}"

if [[ "${exit_code}" == "0" ]]; then
  echo ":: It's working!"
else
  echo ":: Test Failed :("
  exit_code=1
fi

exit ${exit_code}
