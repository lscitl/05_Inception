#!/bin/sh

# for mysql_install_db
mkdir -p /auth_pam_tool_dir
touch /auth_pam_tool_dir/auth_pam_tool

# init mariadb
mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db

# create user and set pw
/usr/bin/mysqld --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PW';
GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%';

CREATE DATABASE IF NOT EXISTS $GITEA_DB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '$GITEA_USER'@'%' IDENTIFIED BY '$GITEA_USER_PW';
GRANT ALL ON $GITEA_DB.* TO '$GITEA_USER'@'%' IDENTIFIED BY '$GITEA_USER_PW';

ALTER USER '$MARIADB_ADMIN'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PW';
FLUSH PRIVILEGES;

EOF
