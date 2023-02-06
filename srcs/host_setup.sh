#!/bin/bash

user=`whoami`

if [ $user != "root" ]
then
	echo "run with sudo"
	exit 1
fi

USER=ssduk

# apt update
apt-get update
apt-get upgrade -y

# install docker
apt-get install \
	ca-certificates \
    curl \
    gnupg \
    lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

chmod a+r /etc/apt/keyrings/docker.gpg
apt-get update

apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# post-installation steps
groupadd docker
usermod -aG docker $USER

chown "$USER":"$USER" /home/"$USER"/.docker -R
chmod g+rwx "$HOME/.docker" -R

# host set
cat << EOF | tee -a /etc/hosts
#Inception host setting
::1     $USER.42.kr
EOF

