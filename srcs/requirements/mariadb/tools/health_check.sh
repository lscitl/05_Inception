#!/bin/sh

if [ `mysql --user=$MARIADB_ADMIN --password=$MARIADB_ADMIN_PW -h localhost -e "use $MARIADB_NAME"` ];
then
    exit 1
fi
