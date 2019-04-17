FROM alpine:3.9

USER root

ENV APP_DIR "/usr/src/app"
ENV PATH "$APP_DIR/bin/:$PATH"

WORKDIR $APP_DIR

RUN apk add --no-cache bash

# see https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#user
RUN addgroup -S docker && adduser -S -D docker -G docker
RUN chown -R docker $APP_DIR

USER docker

COPY --chown=docker:docker . ./

ENTRYPOINT [ "wait-for" ]
