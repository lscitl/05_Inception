# syntax=docker/dockerfile:1

FROM alpine:3.17

ARG FTP_SSL_PATH=/etc/vsftpd/ssl \
	FTP_DOMAIN_NAME=ftp.seseo.42.kr

RUN apk add --update --no-cache \
	vsftpd \
	openssl && \
	mkdir -p /scripts /var/ftp

COPY ./tools/selfsign.sh /scripts/selfsign.sh
COPY ./tools/start.sh /scripts/start.sh
COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN chmod -R 755 /scripts && \
	/scripts/selfsign.sh

EXPOSE 20 21 2100-2110

ENTRYPOINT [ "/scripts/start.sh" ]
