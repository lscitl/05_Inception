#!/bin/sh

# for mysql_install_db
mkdir /auth_pam_tool_dir
touch /auth_pam_tool_dir/auth_pam_tool

# init mariadb
mysql_install_db --user=root --basedir=/usr --datadir=/var/www/html/wpdb --skip-test-db

# create user and set pw
/usr/bin/mysqld --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PW';
GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%';
ALTER USER '$MARIADB_ADMIN'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PW';
FLUSH PRIVILEGES;
EOF

exec /usr/bin/mysqld
