# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk add --update --no-cache \
    vsftpd \
    openssl

RUN sed -i "s|^.*anonymous_enable=.*|anonymous_enable=NO|g" /etc/vsftpd/vsftpd.conf && \
    sed -i "s|^.*local_enable=.*|local_enable=YES|g" /etc/vsftpd/vsftpd.conf && \
    sed -i "s|^.*write_enable=.*|write_enable=YES|g" /etc/vsftpd/vsftpd.conf && \
    sed -i "s|^.*listen=.*|listen=YES|g" /etc/vsftpd/vsftpd.conf


EXPOSE 20 21

CMD [ "redis-cli" ]
