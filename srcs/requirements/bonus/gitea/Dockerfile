# syntax=docker/dockerfile:1

FROM alpine:3.17.2

RUN apk add --update --no-cache gitea 

COPY ./tools/start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 4242

ENTRYPOINT su gitea -c /start.sh