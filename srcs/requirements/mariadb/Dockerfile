# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk add --update --no-cache \
    mariadb \
    mariadb-server-utils \
    mariadb-client

COPY tools/setup.sh /scripts/setup.sh
COPY tools/health_check.sh /scripts/health_check.sh
COPY conf/my.cnf /etc/my.cnf

# make socket and volume mount directory.
RUN mkdir -p /run/mysqld && \
    mkdir -p /var/www/html/wpdb && \
    chown -R mysql:mysql /var/www/html/wpdb && \
    chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT [ "/scripts/setup.sh" ]

# health check
HEALTHCHECK --interval=1s --timeout=1s --retries=30 --start-period=3s CMD /scripts/health_check.sh
