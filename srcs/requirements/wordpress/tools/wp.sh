#!/bin/sh

wp core is-installed --path=$WP_PATH &> /dev/null
if [ $? -ne 0 ] ; then
	echo "=> WordPress is not configured yet, configuring WordPress and create admin and user."

	# create config file.
	wp config create --path=$WP_PATH \
					--dbname=$MARIADB_NAME \
					--dbuser=$MARIADB_USER \
					--dbpass=$MARIADB_USER_PW \
					--dbhost=$MARIADB_CONTAINER_NAME

	# set ftp config
	wp config set "FS_METHOD" ftpext --path=$WP_PATH
	wp config set "FTP_HOST" $FTP_HOST --path=$WP_PATH
	wp config set "FTP_USER" $FTP_USER --path=$WP_PATH
	wp config set "FTP_PASS" $FTP_PASS --path=$WP_PATH
	wp config set "FTP_SSL" true --raw --path=$WP_PATH

	# set redis config
	wp config set "WP_REDIS_HOST" $REDIS_HOST --path=$WP_PATH
	wp config set "WP_REDIS_PORT" $PORT_REDIS --raw --path=$WP_PATH
	wp config set "WP_REDIS_TIMEOUT" 1 --raw --path=$WP_PATH
	wp config set "WP_REDIS_READ_TIMEOUT" 1 --raw --path=$WP_PATH
	wp config set "WP_REDIS_DATABASE" 0 --raw --path=$WP_PATH

	# set admin
	wp core install --path=$WP_PATH \
					--url=$WP_URL \
					--title=$WP_TITLE \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PW \
					--admin_email=$WP_ADMIN_EMAIL

	# set user as author
	wp user create $WP_USER $WP_USER_EMAIL \
					--path=$WP_PATH \
					--role=author \
					--user_pass=$WP_USER_PW
	
	wp plugin delete $(wp plugin list --status=inactive --field=name --path=$WP_PATH) --path=$WP_PATH
fi

# redis-cache plugin install
wp plugin is-installed redis-cache --path=$WP_PATH &> /dev/null
if [ $? -ne 0 ]; then
	wp plugin install redis-cache --path=$WP_PATH
fi

# redis-cache plugin activate
wp plugin is-active redis-cache --path=$WP_PATH &> /dev/null
if [ $? -ne 0 ]; then
	wp plugin activate redis-cache --path=$WP_PATH
	wp plugin auto-updates enable redis-cache --path=$WP_PATH
	wp redis enable --path=$WP_PATH
fi
