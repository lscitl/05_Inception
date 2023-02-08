#!/bin/sh

cat >> /etc/vsftpd/vsftpd.conf << EOF
listen=NO

pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES

rsa_cert_file=/etc/ssl/private/vsftpd.crt
rsa_private_key_file=/etc/ssl/private/vsftpd.key

port_enable=YES

ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=NO
ssl_sslv2=NO
ssl_sslv3=YES

require_ssl_reuse=NO
ssl_ciphers=HIGH
allow_writeable_chroot=YES
listen_port=21
ftp_data_port=20

pasv_enable=YES

# port range
pasv_min_port=2100
pasv_max_port=2101

EOF