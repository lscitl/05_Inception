# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG NGINX_VER=1.22.1-r0

RUN apk add --update --no-cache \
	nginx=${NGINX_VER} \
	openssl

RUN mkdir -p /var/www/html; \
	mkdir -p /etc/nginx/ssl; \
	chmod 700 /etc/nginx/ssl

RUN openssl genrsa -out /etc/nginx/ssl/seseo.42.kr.key 2048 && \
	openssl req \
	-new \
	-key /etc/nginx/ssl/seseo.42.kr.key \ 
	-out /etc/nginx/ssl/seseo.42.kr.csr \
	-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=seseo/CN=seseo.42.kr/emailAddress=seseo@student.42seoul.kr" && \
	openssl x509 \
	-req \
	-days 365 \
	-in /etc/nginx/ssl/seseo.42.kr.csr \
	-signkey /etc/nginx/ssl/seseo.42.kr.key \
	-out /etc/nginx/ssl/seseo.42.kr.crt

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

CMD [ "nginx", "-g", "daemon off;" ]

EXPOSE 443