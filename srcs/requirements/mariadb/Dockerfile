# syntax=docker/dockerfile:1

FROM alpine

ARG MARIADB_VER=10.6.11-r0

RUN apk add --update --no-cache coreutils shadow openrc mariadb=${MARIADB_VER}; \
    openrc; touch /run/openrc/softlevel; /etc/init.d/mariadb setup

# CMD ["rc-service", "mariadb", "restart"]
RUN rc-service mariadb restart

