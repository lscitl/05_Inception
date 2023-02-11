# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ssduk <ssduk@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/25 16:48:49 by seseo             #+#    #+#              #
#    Updated: 2023/02/11 18:42:30 by ssduk            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# for docker compose
DC				:= docker compose
DC_SRC			:= ./srcs/docker-compose.yml

DI				:= docker image
DIL				:= $(DI)s

DATA_PATH 		:= $(HOME)/data

# containers
CONTAINER_MARIADB	:= mariadb
CONTAINER_WORDPRESS	:= wordpress
CONTAINER_NGINX		:= nginx

# bonus
CONTAINER_VSFTPD	:= vsftpd
CONTAINER_REDIS		:= redis
CONTAINER_ADMINOR	:= adminor
CONTAINER_GIT		:= git
CONTAINER_STATIC	:= static


.PHONY:	all
all:	up

.PHONY: build
build:
		mkdir -p $(DATA_PATH)/wp $(DATA_PATH)/wpdb
		$(DC) -f $(DC_SRC) build

.PHONY:	up
up:		build
		$(DC) -f $(DC_SRC) up

.PHONY:	down
down:
		$(DC) -f $(DC_SRC) down

.PHONY:	show_img
show_img:
		$(DIL)

.PHONY:	re
re:		clean
		make up

.PHONY:	clean
clean:	down
		$(DC) -f $(DC_SRC) down -v --rmi all

.PHONY:	fclean
fclean: clean
		rm -rf $(DATA_PATH)
