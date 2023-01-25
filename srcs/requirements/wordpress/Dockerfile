# syntax=docker/dockerfile:1
FROM alpine:3.17

ARG PHP_VER=8.1.14-r0

RUN apk add --update --no-cache \
    php81-common=${PHP_VER} \
    php81-cgi=${PHP_VER} \
    # php81-session={PHP_VER} \
    # php81-iconv={PHP_VER} \
    # php81-json={PHP_VER} \
    # php81-gd={PHP_VER} \
    # php81-curl={PHP_VER} \
    # php81-xml={PHP_VER} \
    # php81-mysqli={PHP_VER} \
    # php81-imap={PHP_VER} \
    # php81-cgi={PHP_VER} \
    # php81-pdo={PHP_VER} \
    # php81-pdo_mysql={PHP_VER} \
    # php81-soap={PHP_VER} \
    # php81-xmlrpc={PHP_VER} \
    # php81-posix={PHP_VER} \
    # php81-mcrypt={PHP_VER} \
    # php81-gettext={PHP_VER} \
    # php81-ldap={PHP_VER} \
    # php81-ctype={PHP_VER} \
    # php81-dom={PHP_VER} \
    # php81-simplexml={PHP_VER} \
    # wget \
    fcgi=2.4.2-r2 \
    tar

ADD http://wordpress.org/latest.tar.gz ~/

RUN tar -xzvf ~/latest.tar.gz && \
    rm ~/latest.tar.gz && \
    ln -s ~/wordpress/ /var/www/localhost/htdocs/wordpress

# CMD ["wget", "http://wordpress.org/latest.tar.gz"]
