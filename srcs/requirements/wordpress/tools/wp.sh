#!/bin/sh

# sleep 5

if ! $(wp core is-installed  --allow-root --path="$WP_PATH"); then
	echo "=> WordPress is not configured yet, configuring WordPress ..."

	echo "=> Installing WordPress"

	wp core download --allow-root \
					--path="$WP_PATH"

	wp config create --allow-root \
					--path="$WP_PATH" \
					--dbname="$MARIADB_NAME" \
					--dbuser="$MARIADB_USER" \
					--dbpass="$MARIADB_USER_PW" \
					--dbhost="$MARIADB_CONTAINER_NAME" 

	wp core install --allow-root \
					--path="$WP_PATH" \
					--url="$WP_URL" \
					--title="$WP_TITLE" \
					--admin_user="$WP_ADMIN" \
					--admin_password="$WP_ADMIN_PW" \
					--admin_email="$WP_ADMIN_EMAIL"

	wp user create $WP_USER $WP_USER_EMAIL \
					--allow-root \
					--path="$WP_PATH" \
					--role=author \
					--user_pass=$WP_USER_PW

	exec php-fpm81 -F
else
	echo "=> WordPress is alread configured.";
	exec php-fpm81 -F
fi


