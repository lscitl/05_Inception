# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG	REDIS_HOST \
	REDIS_PW

RUN adduser -D -S -H -u 82 -G www-data www-data

RUN apk add --update --no-cache redis && \
	mkdir -p /etc/redis

# COPY ./conf/redis.conf /etc/redis.conf

RUN	sed -i "s|bind 127.0.0.1 -::1.*|bind $REDIS_HOST|g" /etc/redis.conf && \
	sed -i "s|# requirepass foobared.*|requirepass $REDIS_PW|g" /etc/redis.conf && \
	sed -i '/locale-collate/d' /etc/redis.conf && \
	sed -i '/set-max-listpack/d' /etc/redis.conf

EXPOSE 6379

ENTRYPOINT redis-server /etc/redis.conf --protected-mode no
