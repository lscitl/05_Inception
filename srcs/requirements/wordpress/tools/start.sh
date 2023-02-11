#!/bin/sh

su -c /scripts/wp.sh wpuser

exec php-fpm81 -F