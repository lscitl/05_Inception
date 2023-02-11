#!/bin/sh

mysql --user=$MARIADB_USER --password=$MARIADB_USER_PW -h localhost -e "use $MARIADB_NAME"
if [ $? -ne 0 ];
then
    exit 1
fi
