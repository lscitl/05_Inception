#!/bin/sh

mkdir -p /var/www $SSL_PATH

chmod 700 $SSL_PATH 

openssl genrsa -out $SSL_PATH/$DOMAIN_NAME.key 2048

openssl req \
        -new \
        -key $SSL_PATH/$DOMAIN_NAME.key \
        -out $SSL_PATH/$DOMAIN_NAME.csr \
        -subj /C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=seseo/CN=$DOMAIN_NAME/emailAddress=$EMAIL

openssl x509 \
        -req \
        -days 365 \
        -in $SSL_PATH/$DOMAIN_NAME.csr \
        -signkey $SSL_PATH/$DOMAIN_NAME.key \
        -out $SSL_PATH/$DOMAIN_NAME.crt