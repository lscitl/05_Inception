# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG WP_PATH=/var/www/html
ARG PHP_VER=8.1.14-r0

RUN apk add --update --no-cache \
    php81=${PHP_VER} \
    php81-fpm=${PHP_VER} \
    php81-phar=${PHP_VER} \
    php81-cgi=${PHP_VER} \
    php81-session=${PHP_VER} \
    php81-iconv=${PHP_VER} \
    php81-gd=${PHP_VER} \
    php81-curl=${PHP_VER} \
    php81-xml=${PHP_VER} \
    php81-mysqli=${PHP_VER} \
    php81-imap=${PHP_VER} \
    php81-cgi=${PHP_VER} \
    php81-pdo=${PHP_VER} \
    php81-pdo_mysql=${PHP_VER} \
    php81-soap=${PHP_VER} \
    php81-posix=${PHP_VER} \
    php81-gettext=${PHP_VER} \
    php81-ldap=${PHP_VER} \
    php81-ctype=${PHP_VER} \
    php81-dom=${PHP_VER} \
    php81-simplexml=${PHP_VER} \
    fcgi \
    tar \
    curl \
    mariadb-client && \
    mkdir -p /var/www/html 

COPY tools/wp.sh /wp.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp

RUN adduser -u 82 -D -S -G www-data www-data && \
    chown -R www-data:www-data /var/www && \
    chmod +x /wp.sh

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT [ "./wp.sh" ]

# health check default set
HEALTHCHECK --interval=1s --timeout=1s --retries=3 CMD curl -f http://localhost:9000 || exit 1