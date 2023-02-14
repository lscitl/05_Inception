# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: seseo <seseo@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/25 16:48:49 by seseo             #+#    #+#              #
#    Updated: 2023/02/14 17:17:02 by seseo            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# for docker compose
DC					:= docker compose
DC_SRC				:= ./srcs/docker-compose.yml

DI					:= docker image
DIL					:= $(DI)s

DV					:= docker volume
DVL					:= $(DV) ls

DN					:= docker network
DNL					:= $(DN) ls


DATA_PATH 			:= $(HOME)/data

# mandatory containers
CONTAINER_MARIADB	:= mariadb
CONTAINER_WORDPRESS	:= wordpress
CONTAINER_NGINX		:= nginx

# bonus containers
CONTAINER_VSFTPD	:= vsftpd
CONTAINER_REDIS		:= redis
CONTAINER_ADMINER	:= adminer
CONTAINER_GITEA		:= gitea
CONTAINER_STATIC	:= static

TARGET				:= inception

.PHONY:	all
all:	up

.PHONY: mkdir
mkdir:
		mkdir -p $(DATA_PATH)/wp $(DATA_PATH)/wpdb $(DATA_PATH)/git

.PHONY:	up
up:		mkdir
		$(DC) -f $(DC_SRC) -p $(TARGET) up -d

.PHONY:	down
down:
		$(DC) -f $(DC_SRC) -p $(TARGET) down

.PHONY:	re
re:		clean
		make up

.PHONY:	clean
clean:
		$(DC) -f $(DC_SRC) -p $(TARGET) down -v --rmi all

.PHONY:	fclean
fclean: clean
		sudo rm -rf $(HOME)/data

.PHONY:	img_ls
img_ls:
		$(DIL)

.PHONY:	vol_ls
vol_ls:
		$(DVL)

.PHONY:	net_ls
net_ls:
		$(DNL)