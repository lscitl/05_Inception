#!/bin/sh

WP_PATH=/var/www/html

wp --allow-root core is-installed --path=$WP_PATH &> /dev/null
if [ $? -ne 0 ] ; then
	echo "=> WordPress is not configured yet, configuring WordPress and create admin and user."

	# create config file.
	wp --allow-root config create --path=$WP_PATH \
					--dbname=$MARIADB_NAME \
					--dbuser=$MARIADB_USER \
					--dbpass=$MARIADB_USER_PW \
					--dbhost=$MARIADB_HOST --extra-php << EOF
define( 'WP_CACHE', true );
WP_CACHE_KEY_SALT

define( 'WP_REDIS_HOST', '$REDIS_HOST' );
define( 'WP_REDIS_PASSWORD', '$REDIS_PW' );
define( 'WP_REDIS_PORT', '$PORT_REDIS' );

EOF
	sed -i "/define( 'WP_CACHE_KEY_SALT.*/d" $WP_PATH/wp-config.php
	sed -i "s|WP_CACHE_KEY_SALT|define( 'WP_CACHE_KEY_SALT', '$DOMAIN_NAME' );|g" $WP_PATH/wp-config.php

	# set admin
	wp --allow-root core install --path=$WP_PATH \
					--url=$WP_URL \
					--title=$WP_TITLE \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PW \
					--admin_email=$WP_ADMIN_EMAIL

	# set user as author
	wp --allow-root user create $WP_USER $WP_USER_EMAIL \
					--path=$WP_PATH \
					--role=author \
					--user_pass=$WP_USER_PW

	wp --allow-root plugin delete $(wp --allow-root plugin list --status=inactive --field=name --path=$WP_PATH) --path=$WP_PATH
fi

# redis-cache plugin install
wp --allow-root plugin is-installed redis-cache --path=$WP_PATH &> /dev/null
if [ $? -ne 0 ]; then
	wp --allow-root plugin install redis-cache --path=$WP_PATH
fi

# redis-cache plugin activate
wp --allow-root plugin is-active redis-cache --path=$WP_PATH &> /dev/null
if [ $? -ne 0 ]; then
	wp --allow-root plugin activate redis-cache --path=$WP_PATH
	wp --allow-root plugin auto-updates enable redis-cache --path=$WP_PATH
	wp --allow-root redis enable --path=$WP_PATH
fi

chown -R www-data:www-data /var/www/html

exec php-fpm81 -F
