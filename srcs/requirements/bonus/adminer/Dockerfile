# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG PORT_ADMINER

RUN adduser -D -u 42 -S -H -G www-data www-data

RUN apk add --update --no-cache \
    php81 \
    php81-common \
    php81-fpm \
    php81-iconv \
    php81-json \
    php81-mysqli \
    php81-session

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

RUN sed -i "s|.*listen *=.*|listen = $PORT_ADMINER |g" /etc/php81/php-fpm.d/www.conf && \
	mkdir -p /var/www/html

ADD https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php /var/www/html/index.php

RUN chown -R www-data:www-data /var/www/html

EXPOSE 4433

ENTRYPOINT [ "php-fpm81", "-F"]