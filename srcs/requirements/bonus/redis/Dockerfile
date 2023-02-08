# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk add --update --no-cache \
    redis

RUN mkdir -p /var/www; \
    mkdir -p /etc/nginx/ssl; \
    chmod 700 /etc/nginx/ssl

RUN openssl genrsa -out /etc/nginx/ssl/${DOMAIN_NAME}.key 2048 && \
    openssl req \
    -new \
    -key /etc/nginx/ssl/${DOMAIN_NAME}.key \
    -out /etc/nginx/ssl/${DOMAIN_NAME}.csr \
    -subj /C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=seseo/CN=${DOMAIN_NAME}/emailAddress=seseo@student.42seoul.kr && \
    openssl x509 \
    -req \
    -days 365 \
    -in /etc/nginx/ssl/${DOMAIN_NAME}.csr \
    -signkey /etc/nginx/ssl/${DOMAIN_NAME}.key \
    -out /etc/nginx/ssl/${DOMAIN_NAME}.crt

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 6379

CMD [ "redis-cli" ]
