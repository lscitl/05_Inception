#!/bin/sh

/scripts/wp.sh

chown -R www-data:www-data /var/www/html

exec php-fpm81 -F
