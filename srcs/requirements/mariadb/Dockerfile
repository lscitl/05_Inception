# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG MARIADB_ADMIN \
    MARIADB_ADMIN_PW \
    MARIADB_USER \
    MARIADB_USER_PW \
    MARIADB_NAME

RUN apk add --update --no-cache \
    mariadb \
    mariadb-client

COPY tools/setup.sh /setup.sh
COPY conf/my.cnf /etc/my.cnf

# make socket and volume mount directory.
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    chmod +x /setup.sh && \
    /setup.sh

EXPOSE 3306

ENTRYPOINT mysqld --user=mysql --datadir=/var/lib/mysql

# health check
HEALTHCHECK --interval=1s --timeout=1s --retries=30 --start-period=3s \
    CMD mysql --user=$MARIADB_USER --password=$MARIADB_USER_PW -h localhost -e "use $MARIADB_NAME" || exit 1
