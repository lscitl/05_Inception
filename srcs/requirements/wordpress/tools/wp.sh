#!/bin/sh

if ! $(wp core is-installed --allow-root --path=$WP_PATH &> /dev/null); then
	echo "=> WordPress is not configured yet, configuring WordPress and create admin and user."

	# create config file.
	wp config create --allow-root \
					--path=$WP_PATH \
					--dbname=$MARIADB_NAME \
					--dbuser=$MARIADB_USER \
					--dbpass=$MARIADB_USER_PW \
					--dbhost=$MARIADB_CONTAINER_NAME << EOF

/** Sets up ftp. */
define('FS_METHOD', 'ftpext');
define('FTP_HOST', '$FTP_HOST');
define('FTP_USER', '$FTP_USER');
define('FTP_PASS', '$FTP_PASS');
define('FTP_SSL', true);

/** Sets up redis-cache. */
define('WP_REDIS_HOST', 'redis-cache');
define('WP_REDIS_PORT', '6379');
define('WP_REDIS_TIMEOUT', '1');
define('WP_REDIS_READ_TIMEOUT', '1');
define('WP_REDIS_DATABASE', '0');

EOF

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

else
	echo "=> WordPress is alread configured.";
fi

# redis-cache plugin install
if ! $(wp plugin is-installed redis-cache --allow-root --path=$WP_PATH &> /dev/null); then
	# Update plugin
	wp plugin update redis-cache --allow-root --path=$WP_PATH
else
	# Install plugin
	wp plugin install redis-cache --allow-root --path=$WP_PATH
	
fi

if $(wp plugin is-active redis-cache --allow-root --path=$WP_PATH &> /dev/null); then
	wp plugin activate redis-cache --allow-root --path=$WP_PATH
	wp plugin auto-updates enable redis-cache --allow-root --path=$WP_PATH
	wp redis enable --allow-root --path=$WP_PATH
fi

exec php-fpm81 -F
