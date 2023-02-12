#!/bin/bash

user=`whoami`

if [ $user != "root" ]
then
	echo "run with sudo"
	exit 1
fi

# set user
USER=seseo
DOMAIN_NAME=${USER}.42.kr

# host set
if [ -n "$(cat /etc/hosts | grep $DOMAIN_NAME)" ]; then
  echo "host is already added"
else
  cat << EOF | tee -a /etc/hosts
#Inception host setting
::1     $DOMAIN_NAME
EOF
fi

if docker --version; then
  echo "Docker is already installed"
else
  # apt update
  apt-get update && apt-get upgrade -y

  # install docker
  apt-get install ca-certificates curl gnupg lsb-release make -y

  mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

  chmod a+r /etc/apt/keyrings/docker.gpg

  apt-get update && apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

  # post-installation steps
  groupadd docker
  usermod -aG docker $USER

  chown $USER:$USER /home/$USER/.docker -R
  chmod g+rwx /home/$USER/.docker -R

  echo "Docker install finished!"

fi