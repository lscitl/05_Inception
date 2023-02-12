# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG DOMAIN_NAME \
	EMAIL \
	PORT_ADMINER \
	CONFIG_PATH=/etc/nginx/http.d/default.conf

COPY ./conf/default.conf $CONFIG_PATH
COPY ./tools/sign.sh /sign.sh

RUN sed -i "s|DOMAIN_NAME|$DOMAIN_NAME|g" $CONFIG_PATH && \
	sed -i "s|PORT_ADMINER|$PORT_ADMINER|g" $CONFIG_PATH && \
	apk add --update --no-cache nginx openssl && \
	chmod +x /sign.sh && \
	/sign.sh

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]