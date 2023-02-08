#!/bin/sh

if ! $(wp core is-installed  --allow-root --path=$WP_PATH); then
	echo "=> WordPress is not configured yet, configuring WordPress and create admin and user."

	# create config file.
	wp config create --allow-root \
					--path=$WP_PATH \
					--dbname=$MARIADB_NAME \
					--dbuser=$MARIADB_USER \
					--dbpass=$MARIADB_USER_PW \
					--dbhost=$MARIADB_CONTAINER_NAME 

	# set admin
	wp core install --allow-root \
					--path=$WP_PATH \
					--url=$WP_URL \
					--title=$WP_TITLE \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PW \
					--admin_email=$WP_ADMIN_EMAIL

	# set user as author
	wp user create $WP_USER $WP_USER_EMAIL \
					--allow-root \
					--path=$WP_PATH \
					--role=author \
					--user_pass=$WP_USER_PW
					<< EOF

/** Sets up ftp. */
define('FS_METHOD', 'ftpext');
define('FTP_HOST', '$FTP_HOST');
define('FTP_USER', '$FTP_USER');
define('FTP_PASS', '$FTP_PASS');
define('FTP_SSL', true);
EOF

else
	echo "=> WordPress is alread configured.";
fi

exec php-fpm81 -F

