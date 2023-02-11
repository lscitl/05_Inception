# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG SSL_PATH \
	DOMAIN_NAME \
	EMAIL

COPY ./conf/default.conf /etc/nginx/http.d/default.conf
COPY ./tools/sign.sh /sign.sh

RUN apk add --update --no-cache nginx openssl && \
	chmod +x /sign.sh && \
	/sign.sh

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]