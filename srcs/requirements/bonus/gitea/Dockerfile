# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG MARIADB_HOST \
    GITEA_DB \
    GITEA_USER \
    GITEA_USER_PW \
    EMAIL

RUN apk add --update --no-cache gitea curl && \
    mkdir -p /scripts

COPY ./tools/set_config.sh /scripts/set_config.sh
COPY ./tools/start.sh /scripts/start.sh

RUN chmod +x -R /scripts && \
    /scripts/set_config.sh

EXPOSE 3000

STOPSIGNAL SIGKILL

ENTRYPOINT su gitea -c /scripts/start.sh