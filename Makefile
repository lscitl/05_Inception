# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ssduk <ssduk@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/25 16:48:49 by seseo             #+#    #+#              #
#    Updated: 2023/02/12 17:50:42 by ssduk            ###   ########.fr        #
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
CONTAINER_GIT		:= git

TARGET				:= inception

.PHONY:	all
all:	up

.PHONY: build
build:
		mkdir -p $(DATA_PATH)/wp $(DATA_PATH)/wpdb
		$(DC) -f $(DC_SRC) -p $(TARGET) build

.PHONY:	up
up:		build
		$(DC) -f $(DC_SRC) -p $(TARGET) up

.PHONY:	down
down:
		$(DC) -f $(DC_SRC) -p $(TARGET) down

.PHONY:	img_ls
img_ls:
		$(DIL)

.PHONY:	vol_ls
vol_ls:
		$(DVL)

.PHONY:	net_ls
net_ls:
		$(DNL)

.PHONY:	re
re:		clean
		make up

.PHONY:	clean
clean:	down
		$(DC) -f $(DC_SRC) -p $(TARGET) down -v --rmi all

.PHONY:	fclean
fclean: clean
		# sudo rm -rf /home/seseo/data
		sudo rm -rf /home/ssduk/data
