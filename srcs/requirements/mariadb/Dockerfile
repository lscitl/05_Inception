# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG MARIADB_VER=10.6.11-r0

RUN apk add --update --no-cache \
    coreutils \
    openrc \
    mariadb=${MARIADB_VER} \
    mariadb-server-utils; \
    mkdir -p /run/openrc \
    touch /run/openrc/softlevel;
    # shadow \
    # pwgen; \

COPY ./tools/setup.sh /scripts/setup.sh

RUN chown -R mysql:mysql /var/lib/mysql; \
    chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT [ "/scripts/setup.sh" ]
