#!/bin/sh

echo www-data:$FTP_PW | chpasswd

vsftpd /etc/vsftpd/vsftpd.conf