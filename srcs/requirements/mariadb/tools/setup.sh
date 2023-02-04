#!/bin/sh

# for mysql_install_db
mkdir /auth_pam_tool_dir
touch /auth_pam_tool_dir/auth_pam_tool

# init mariadb
mysql_install_db --user=root --basedir=/usr --datadir=/var/www/html/wpdb --skip-test-db

# create user and set pw
/usr/bin/mysqld -user=root --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

exec /usr/bin/mysqld
