# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG MARIADB_VER=10.6.11-r0

# coreutils - chmod
RUN apk add --update --no-cache \
    mariadb=${MARIADB_VER} \
    mariadb-server-utils; 


COPY tools/setup.sh /scripts/setup.sh
COPY conf/my.cnf /etc/my.cnf

RUN chown -R mysql:mysql /var/lib/mysql; \
    chmod -R 755 /scripts

# EXPOSE 3306

ENTRYPOINT [ "/scripts/setup.sh" ]
