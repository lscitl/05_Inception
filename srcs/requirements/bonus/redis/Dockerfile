# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk add --update --no-cache \
    redis


EXPOSE 6379

CMD [ "redis-cli" ]
