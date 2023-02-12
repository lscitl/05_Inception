# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG	REDIS_HOST \
	REDIS_PW \
	PORT_REDIS

RUN apk add --update --no-cache redis && \
	mkdir -p /etc/redis

RUN	sed -i "s|bind 127.0.0.1 -::1.*|bind $REDIS_HOST|g" /etc/redis.conf && \
	sed -i "s|# requirepass foobared.*|requirepass $REDIS_PW|g" /etc/redis.conf && \
	sed -i '/locale-collate/d' /etc/redis.conf && \
	sed -i '/set-max-listpack/d' /etc/redis.conf

EXPOSE $PORT_REDIS

COPY ./tools/healthcheck.sh /healthcheck.sh
RUN	chmod +x /healthcheck.sh

ENTRYPOINT redis-server /etc/redis.conf --protected-mode no

HEALTHCHECK --interval=1s --timeout=1s --retries=30 --start-period=3s \
	CMD /healthcheck.sh