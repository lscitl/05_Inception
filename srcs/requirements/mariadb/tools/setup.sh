#!/bin/sh

export MARIADB_NAME=wpdb
export MARIADB_USER=wordpress
export MARIADB_PASSWORD=111111

rc default

/etc/init.d/mariadb setup
rm /var/lib/mysql/ib_logfile*

rc-service mariadb start
rc-service mariadb stop

cat > /etc/my.cnf << EOF
[mysqld]
user = root
datadir = /var/lib/mysql
port = 3306
bind-address = 0.0.0.0
EOF

mkdir /auth_pam_tool_dir
touch /auth_pam_tool_dir/auth_pam_tool

mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql --skip-test-db

/usr/bin/mysqld --bootstrap << EOF
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS test ;
CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='mysql';
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

exec /usr/bin/mysqld

# DELETE FROM mysql.user WHERE User='mariadb.sys';
# USE mysql;
# FLUSH PRIVILEGES;
# GRANT ALL ON *.* TO 'root'@'%' identified by '$MARIADB_PASSWORD' WITH GRANT OPTION ;
# GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MARIADB_PASSWORD' WITH GRANT OPTION ;
# SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MARIADB_PASSWORD}') ;
# DELETE FROM mysql.db WHERE db='test' OR db='test\\_%';
# FLUSH PRIVILEGES ;

# CREATE DATABASE $MARIADB_NAME;
# CREATE USER '$MARIADB_USER'@'%' identified by '$MARIADB_PASSWORD';
# GRANT ALL ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%';
# FLUSH PRIVILEGES;

# EOF


