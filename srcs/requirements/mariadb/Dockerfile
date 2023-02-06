# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk add --update --no-cache \
    mariadb \
    mariadb-server-utils

COPY tools/setup.sh /scripts/setup.sh
COPY conf/my.cnf /etc/my.cnf

# make socket and volume mount directory.
RUN mkdir -p /run/mysqld && \
    mkdir -p /var/www/html/wpdb && \
    chown -R mysql:mysql /var/www/html/wpdb && \
    chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT [ "/scripts/setup.sh" ]

HEALTHCHECK --interval=1s --timeout=1s --retries=3 CMD curl -f http://localhost:3306 || exit 1