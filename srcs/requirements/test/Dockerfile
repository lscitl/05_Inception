# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG NGINX_VER=1.22.1-r0

RUN apk add --update --no-cache \
	nginx=${NGINX_VER} \
	openssl

RUN mkdir -p /var/www; \
	mkdir -p /etc/nginx/ssl; \
	chmod 700 /etc/nginx/ssl

RUN openssl req -x509 \
				-newkey rsa:2048 \
				-nodes \
				-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=seseo" \
				-keyout /etc/nginx/ssl/localhost.seseo.key \
				-out /etc/nginx/ssl/localhost.seseo.crt

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
