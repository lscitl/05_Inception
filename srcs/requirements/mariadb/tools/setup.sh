#!/bin/sh

export MARIADB_USER=wordpress
export MARIADB_PASSWORD=111111

rc default

/etc/init.d/mariadb setup
rm /var/lib/mysql/ib_logfile*

rc-service mariadb start
rc-service mariadb stop

<< EOF cat >/etc/my.cnf
user = root
datadir = /var/lib/mysql
port = 3306
log-bin = /var/lib/mysql/mysql-bin
bind-address = 0.0.0.0
skip-networking = 0
EOF

/usr/bin/mysqld --user=root --bootstrap << EOF
create database wpdb;
create user '$MARIADB_USER'@'%' identified by '$MARIADB_PASSWORD';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, CREATE VIEW, EVENT, TRIGGER, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON wpdb.* TO '$MARIADB_USER'@'%';

ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD("$MARIADB_PASSWORD");
DELETE FROM mysql.user WHERE User='mariadb.sys';
DELETE FROM mysql.user WHERE User='mysql';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE db='test' OR db='test\\_%';

FLUSH PRIVILEGES;
EOF


exec /usr/bin/mysqld --user=root