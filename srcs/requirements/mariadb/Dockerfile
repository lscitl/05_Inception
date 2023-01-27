# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG MARIADB_VER=10.6.11-r0

RUN apk add --update --no-cache \
    coreutils \
    shadow \
    openrc \
    mariadb=${MARIADB_VER} \
    mariadb-server-utils \
    pwgen; \
    mkdir -p /run/openrc \
    touch /run/openrc/softlevel;

COPY ./tools/setup.sh /scripts/setup.sh

RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT [ "/scripts/setup.sh" ]
