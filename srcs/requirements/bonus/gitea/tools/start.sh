#!/bin/sh

gitea &

while [ "`curl -s -o /dev/null -I -w "%{http_code}" 127.0.0.1:3000`" != "200" ]
do
    sleep 1
done
kill "$!"

if [ -z "`gitea admin user list | grep root`" ]; then
    echo "add users"
    gitea admin user create --admin --username root --password $GITEA_USER_PW --email root@example.com
    gitea admin user create --username $GITEA_USER --password $GITEA_USER_PW --email $EMAIL
else
    echo "gitea users are already added."
fi

gitea