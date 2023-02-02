#!/bin/sh

if ! $(wp core is-installed  --allow-root --path="$WORDPRESS_PATH"); then
   echo "=> WordPress is not configured yet, configuring WordPress ..."

   echo "=> Installing WordPress"
   wp core install --allow-root \
   					--path="$WORDPRESS_PATH" \
   					--url="$WORDPRESS_URL" \
					--title="$WORDPRESS_TITLE" \
					--admin_user="$WORDPRESS_ADMIN_USER" \
					--admin_password="$WORDPRESS_ADMIN_PASSWORD" \
					--admin_email="$WORDPRESS_ADMIN_EMAIL"
else
   echo "=> WordPress is alread configured.";
fi
