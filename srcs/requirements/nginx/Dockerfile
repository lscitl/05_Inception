# syntax=docker/dockerfile:1
FROM alpine:3.17

RUN apk add --update --no-cache \
    nginx=1.22.1-r0

COPY ./conf/default.conf 

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]