#!/bin/sh

mysql --user=$MARIADB_ADMIN --password=$MARIADB_ADMIN_PW -h localhost -e "use $MARIADB_NAME"
if [ $? -ne 0 ];
then
    exit 1
fi
