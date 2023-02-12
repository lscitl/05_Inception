# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG EMAIL \
	DOMAIN_NAME \
	PORT_FTP_MIN \
	PORT_FTP_MAX

RUN apk add --update --no-cache \
	vsftpd \
	openssl && \
	mkdir -p /scripts /var/ftp

COPY ./tools/sign.sh /scripts/sign.sh
COPY ./tools/start.sh /scripts/start.sh
COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN adduser -D -u 42 -h /var/ftp -G www-data www-data

RUN chmod -R 755 /scripts && \
	/scripts/sign.sh

RUN	sed -i "s|PORT_FTP_MIN|$PORT_FTP_MIN|g"  /etc/vsftpd/vsftpd.conf && \
	sed -i "s|PORT_FTP_MAX|$PORT_FTP_MAX|g"  /etc/vsftpd/vsftpd.conf && \
    chown -R www-data:www-data /var/ftp

EXPOSE 21

STOPSIGNAL SIGKILL

ENTRYPOINT scripts/start.sh
