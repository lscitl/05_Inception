# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: seseo <seseo@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/25 16:48:49 by seseo             #+#    #+#              #
#    Updated: 2023/02/06 21:48:59 by seseo            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# for docker compose
DC				:= docker compose
# DC				:= sudo docker compose
DC_SRC			:= ./srcs/docker-compose.yml

DI				:= docker image
# DI				:= sudo docker image
DIL				:= $(DI)s

# containers
MARIADB_CONTAINER	:= mariadb
WORDPRESS_CONTAINER	:= wordpress
NGINX_CONTAINER		:= nginx

.PHONY:	up down
up down:
		$(DC) -f $(DC_SRC) $@

.PHONY:	show_img
show_img:
		$(DIL)

.PHONY:	clean
clean:	down
		$(DI) rm -f `$(DIL) -a -q`
		$(DC) -f $(DC_SRC) down -v
