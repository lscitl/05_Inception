#!/bin/sh

openssl genrsa -out /etc/nginx/ssl/seseo.42.kr.key 2048

openssl req \
	-new \
	-key /etc/nginx/ssl/seseo.42.kr.key \
	-out /etc/nginx/ssl/seseo.42.kr.csr \
	-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=seseo/CN=seseo.42.kr/emailAddress=seseo@student.42seoul.kr"

openssl x509 \
	-req \
	-days 365 \
	-in /etc/nginx/ssl/seseo.42.kr.csr \
	-signkey /etc/nginx/ssl/seseo.42.kr.key \
	-out /etc/nginx/ssl/seseo.42.kr.crt

nginx -g deamon off
