# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG WP_PATH=/var/www/html

RUN apk add --update --no-cache \
    php81 \
    php81-fpm \
    php81-phar \
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
    php81-simplexml \
    php81-redis \
    php81-ftp \
    fcgi \
    tar \
    curl \
    mariadb-client && \
    mkdir -p /var/www/html

COPY tools/wp.sh /wp.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp && \
    wp core download --allow-root --path=$WP_PATH

RUN adduser -u 82 -D -S -G www-data www-data && \
    chown -R www-data:www-data /var/www && \
    chmod +x /wp.sh

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT [ "./wp.sh" ]

# health check set
HEALTHCHECK --interval=1s --timeout=1s --retries=30 \
    CMD wp core is-installed --allow-root --path="$WP_PATH" || exit 1
