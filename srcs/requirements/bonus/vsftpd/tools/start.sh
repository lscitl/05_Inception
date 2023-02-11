#!/bin/sh

if [ ! "`cat /etc/passwd | grep $FTP_USER`" ]; then

    adduser -D -h /var/ftp $FTP_USER

    chpasswd << EOF
$FTP_USER:$FTP_PASS
EOF

    chown -R $FTP_USER:$FTP_USER /var/ftp

fi

vsftpd /etc/vsftpd/vsftpd.conf
