#!/bin/sh

# tmp env
export MARIADB_NAME=wpdb
export MARIADB_USER=wordpress
export MARIADB_PASSWORD=111111

# for mysql_install_db
mkdir /auth_pam_tool_dir
touch /auth_pam_tool_dir/auth_pam_tool

# init mariadb
mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql --skip-test-db

# create user and set pw
/usr/bin/mysqld -user=root --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%';
FLUSH PRIVILEGES;
EOF

exec /usr/bin/mysqld


# ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
# exec /usr/bin/mysqld_safe --datadir='/var/lib/mysql'

# DROP DATABASE IF EXISTS test ;
# DELETE FROM mysql.user WHERE User='';
# DELETE FROM mysql.user WHERE User='mysql';
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


