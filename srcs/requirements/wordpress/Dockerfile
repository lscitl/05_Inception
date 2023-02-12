# syntax=docker/dockerfile:1

FROM alpine:3.17.2

RUN apk add --update --no-cache \
    php81 \
    php81-fpm \
    php81-phar \
    php81-session \
    php81-iconv \
    php81-curl \
    php81-mysqli \
    php81-tokenizer \
    php81-ftp \
    mariadb-client && \
    mkdir -p /var/www/html /scripts

COPY ./tools/wp.sh /scripts/wp.sh
COPY ./tools/start.sh /scripts/start.sh
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/bin/wp

RUN adduser -D -u 42 -S -G www-data www-data

RUN chmod 755 /usr/bin/wp && \
    chmod +x -R /scripts && \
    wp core download --allow-root --path=/var/www/html

EXPOSE 9000

ENTRYPOINT [ "/scripts/start.sh" ]

# health check set
HEALTHCHECK --interval=1s --timeout=1s --retries=30 --start-period=3s \
    CMD wp core is-installed --allow-root --path=/var/www/html
