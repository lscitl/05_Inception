# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG FTP_SSL_PATH \
	FTP_DOMAIN_NAME \
	EMAIL

RUN apk add --update --no-cache \
	vsftpd \
	openssl && \
	mkdir -p /scripts /var/ftp

COPY ./tools/sign.sh /scripts/sign.sh
COPY ./tools/start.sh /scripts/start.sh
COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN chmod -R 755 /scripts && \
	/scripts/sign.sh

EXPOSE 20 21 2100-2110

STOPSIGNAL SIGKILL

ENTRYPOINT [ "/scripts/start.sh" ]
