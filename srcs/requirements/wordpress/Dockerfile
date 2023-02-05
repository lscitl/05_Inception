# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG PHP_VER=8.1.14-r0
ARG WP_VER=6.1.1
ARG WP_CLI_VER=2.7.1
ARG WP_PATH=/var/www/html

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
    curl

RUN mkdir -p /var/www/html && \
    curl -L "https://wordpress.org/latest.tar.gz" > /latest.tar.gz && \
    tar -xzf /latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm /latest.tar.gz

COPY conf/wp-config.php /var/www/html/wp-config.php
COPY tools/wp.sh /wp.sh

RUN curl -L "https://github.com/wp-cli/wp-cli/releases/download/v2.7.1/wp-cli-2.7.1.phar" > /usr/bin/wp && \
    chmod +x /usr/bin/wp

RUN adduser -u 82 -D -S -G www-data www-data && \
    chown -R www-data:www-data /var/www && \
    chmod +x /wp.sh

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT [ "./wp.sh" ]
