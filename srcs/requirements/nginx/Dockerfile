# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG SSL_PATH=/etc/nginx/ssl \
	DOMAIN_NAME=seseo.42.kr

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

RUN apk add --update --no-cache nginx openssl && \
	mkdir -p /var/www && \
	mkdir -p ${SSL_PATH} && \
	chmod 700 ${SSL_PATH} 

RUN openssl genrsa -out ${SSL_PATH}/${DOMAIN_NAME}.key 2048 && \
	openssl req \
	-new \
	-key ${SSL_PATH}/${DOMAIN_NAME}.key \
	-out ${SSL_PATH}/${DOMAIN_NAME}.csr \
	-subj /C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=seseo/CN=${DOMAIN_NAME}/emailAddress=seseo@student.42seoul.kr && \
	openssl x509 \
	-req \
	-days 365 \
	-in ${SSL_PATH}/${DOMAIN_NAME}.csr \
	-signkey ${SSL_PATH}/${DOMAIN_NAME}.key \
	-out ${SSL_PATH}/${DOMAIN_NAME}.crt

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]