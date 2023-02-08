# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: seseo <seseo@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/25 16:48:49 by seseo             #+#    #+#              #
#    Updated: 2023/02/08 21:50:22 by seseo            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# for docker compose
DC				:= docker compose
DC_SRC			:= ./srcs/docker-compose.yml

DI				:= docker image
DIL				:= $(DI)s

DATA_PATH 		:= /home/seseo/data

# containers
MARIADB_CONTAINER	:= mariadb
WORDPRESS_CONTAINER	:= wordpress
NGINX_CONTAINER		:= nginx


.PHONY:	all
all:	up

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

.PHONY:	up
up:
		# mkdir -p $(DATA_PATH)/wp $(DATA_PATH)/wpdb
		$(DC) -f $(DC_SRC) up
