# syntax=docker/dockerfile:1

FROM alpine:3.17.2

RUN apk add --update --no-cache git openssh-server && \
    adduser -D git -s /bin/sh && \
    su git -c "ssh-keygen -t rsa -C git -f /home/git/.ssh/id_rsa -P ''"

ENTRYPOINT git
