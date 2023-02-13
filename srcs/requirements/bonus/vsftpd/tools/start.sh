#!/bin/sh

echo $FTP_USER:$FTP_PW | chpasswd

exec vsftpd /etc/vsftpd/vsftpd.conf