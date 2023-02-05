#!/bin/sh

openssl genrsa -out /etc/nginx/ssl/${DOMAIN_NAME}.key 2048

openssl req \
	-new \
	-key /etc/nginx/ssl/${DOMAIN_NAME}.key \
	-out /etc/nginx/ssl/${DOMAIN_NAME}.csr \
	-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=seseo/CN=${DOMAIN_NAME}/emailAddress=seseo@student.42seoul.kr"

openssl x509 \
	-req \
	-days 365 \
	-in /etc/nginx/ssl/${DOMAIN_NAME}.csr \
	-signkey /etc/nginx/ssl/${DOMAIN_NAME}.key \
	-out /etc/nginx/ssl/${DOMAIN_NAME}.crt

nginx -g deamon off
