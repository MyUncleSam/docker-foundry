FROM ubuntu:24.04

ARG TARGETPLATFORM
ARG BUILDPLATFORM

ARG STEAM_GAMESERVERID
ARG GAMESERVER_CMD

ARG UID=1000
ARG GID=1000

LABEL maintainer="Stefan Ruepp <stefan@ruepp.info>"
LABEL github="https://github.com/MyUncleSam/docker-foundry/"
LABEL TARGETPLATFORM=${TARGETPLATFORM}
LABEL BUILDPLATFORM=${BUILDPLATFORM}

ENV GAMESERVER_FILES="/server"
ENV STEAM_ADDITIONAL_UPDATE_ARGS=""
ENV TZ="Europe/Berlin"

RUN groupadd -g "${GID}" steam \
    && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" steam

USER steam

ADD scripts/dockerfile/ /build

RUN /bin/bash /build/build.sh

EXPOSE 8999

VOLUME [ "/server", "/foundry", "/home/steam/.steam" ]
CMD [ "/docker/start.sh" ]