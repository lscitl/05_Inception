#!/bin/sh

su -c /scripts/wp.sh wpuser

chown -R wpuser:www-data /var/www/html

exec php-fpm81 -F
