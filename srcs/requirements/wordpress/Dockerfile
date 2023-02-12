# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG WP_PATH \
    PORT_WORDPRESS

RUN apk add --update --no-cache \
    php81 \
    php81-fpm \
    php81-phar \
    php81-json \
    php81-session \
    php81-iconv \
    php81-gd \
    php81-curl \
    php81-xml \
    php81-mysqli \
    php81-imap \
    php81-cgi \
    php81-pdo \
    php81-pdo_mysql \
    php81-soap \
    php81-posix \
    php81-gettext \
    php81-ldap \
    php81-ctype \
    php81-dom \
    php81-fileinfo \
    php81-tokenizer \
    php81-simplexml \
    php81-redis \
    php81-ftp \
    mariadb-client && \
    mkdir -p /var/www/html /var/adminer /scripts

COPY ./tools/wp.sh /scripts/wp.sh
COPY ./tools/start.sh /scripts/start.sh

ADD https://www.adminer.org/latest-mysql.php /var/adminer/adminer.php
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/bin/wp

RUN sed -i "s/.*listen\s*=.*/listen = 9000/g" /etc/php81/php-fpm.d/www.conf && \
    chmod 755 /var/adminer/adminer.php /usr/bin/wp && \
    chmod +x -R /scripts && \
    adduser -D wpuser && \
    wp core download --allow-root --path=$WP_PATH

EXPOSE $PORT_WORDPRESS

ENTRYPOINT [ "/scripts/start.sh" ]

# health check set
HEALTHCHECK --interval=1s --timeout=1s --retries=30 --start-period=3s \
    CMD wp core is-installed --allow-root --path="$WP_PATH" || exit 1
