#!/bin/sh

FTP_SSL_PATH=/etc/vsftpd/ssl
FTP_DOMAIN_NAME=ftp.$DOMAIN_NAME

mkdir -p $FTP_SSL_PATH
chmod 700 $FTP_SSL_PATH

openssl genrsa -out $FTP_SSL_PATH/vsftpd.key 2048

openssl req \
        -new \
        -key $FTP_SSL_PATH/vsftpd.key \
        -out $FTP_SSL_PATH/vsftpd.csr \
        -subj /C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=seseo/CN=$FTP_DOMAIN_NAME/emailAddress=$EMAIL

openssl x509 \
        -req \
        -days 365 \
        -in $FTP_SSL_PATH/vsftpd.csr \
        -signkey $FTP_SSL_PATH/vsftpd.key \
        -out $FTP_SSL_PATH/vsftpd.crt
