# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG NGINX_VER=1.22.1-r0

RUN apk add --update --no-cache nginx=${NGINX_VER}

COPY ./conf/default.conf /etc/nginx/default.conf

EXPOSE 80

# CMD [ "nginx", "-g", "daemon on;" ]