#!/bin/sh

cat > /etc/gitea/app.ini << EOF
RUN_USER = gitea
RUN_MODE = prod

[repository]
ROOT        = /var/lib/gitea/git
SCRIPT_TYPE = sh

[server]
STATIC_ROOT_PATH = /usr/share/webapps/gitea
APP_DATA_PATH    = /var/lib/gitea/data
LFS_START_SERVER = false
SSH_DOMAIN       = localhost
DOMAIN           = localhost
HTTP_PORT        = 3000
ROOT_URL         = http://localhost:3000/
DISABLE_SSH      = true
OFFLINE_MODE     = false

[database]
DB_TYPE  = mysql
SSL_MODE = disable
HOST     = $MARIADB_HOST
NAME     = $GITEA_DB
USER     = $GITEA_USER
PASSWD   = $GITEA_USER_PW

[session]
PROVIDER = file

[log]
ROOT_PATH = /var/log/gitea
MODE      = file
LEVEL     = Info

[security]
INSTALL_LOCK=true

EOF
