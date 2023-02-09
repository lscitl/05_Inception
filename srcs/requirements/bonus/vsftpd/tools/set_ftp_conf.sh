#!/bin/sh

sed -i "s|^.*anonymous_enable=.*|anonymous_enable=NO|g" /etc/vsftpd/vsftpd.conf
sed -i "s|^.*local_enable=.*|local_enable=YES|g" /etc/vsftpd/vsftpd.conf
sed -i "s|^.*write_enable=.*|write_enable=YES|g" /etc/vsftpd/vsftpd.conf
sed -i "s|^.*write_enable=.*|write_enable=YES|g" /etc/vsftpd/vsftpd.conf

cat >> /etc/vsftpd/vsftpd.conf << EOF

# additional ssl settings
listen=NO

pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES

rsa_cert_file=$FTP_SSL_PATH/vsftpd.crt
rsa_private_key_file=$FTP_SSL_PATH/vsftpd.key

port_enable=YES

ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES

# use TLSv1
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO

require_ssl_reuse=NO
ssl_ciphers=HIGH
# allow_writeable_chroot=YES

listen_port=21
ftp_data_port=20

pasv_enable=YES

# port range
pasv_min_port=2100
pasv_max_port=2101
EOF
