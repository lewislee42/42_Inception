# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lewlee <lewlee@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/13 16:19:16 by lewlee            #+#    #+#              #
#    Updated: 2025/03/14 13:24:53 by lewlee           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = Inception
DOCKER_COMPOSE_FILE := docker-compose.yml
DOMAIN_NAME = $(shell awk -F= '/^DOMAIN_NAME=/ {print $$2}' ./srcs/.env)
USER_HOME = $(shell awk -F= '/^USER_HOME=/ {print $$2}' ./srcs/.env)

all: $(NAME)

generate_certs:
	@bash -c "if [[ ! -f ./secrets/dhparam.pem || ! -f ./secrets/cert.pem || ! -f ./secrets/cert.key ]]; then rm ./secrets/*; openssl dhparam -out ./secrets/dhparam.pem 2048; openssl req -new -newkey rsa:2048 -nodes -keyout secrets/cert.key -out secrets/cert.csr -subj '/C=MY/ST=Selangor/L=Subang/O=My Company/OU=IT/CN=$(DOMAIN_NAME)'; openssl x509 -req -days 3650 -in secrets/cert.csr -signkey secrets/cert.key -out secrets/cert.pem; rm secrets/cert.csr; cp ./secrets/* ./srcs/requirements/nginx/tools/; fi"

prep: generate_certs
	@bash -c "if [[ ! -f ./srcs/.env ]]; then echo 'Error: .env file not created in srcs folder'; false; fi"
	@bash -c "if [ ! -d $(USER_HOME)/data ]; then mkdir $(USER_HOME)/data; fi"
	@bash -c "if [ ! -d $(USER_HOME)/data/mariadb ]; then mkdir $(USER_HOME)/data/mariadb; fi"
	@bash -c "if [ ! -d $(USER_HOME)/data/wordpress ]; then mkdir $(USER_HOME)/data/wordpress; fi"
	@sudo bash -c "if ! grep -q '$(DOMAIN_NAME)' /etc/hosts; then sudo cp /etc/hosts $(USER_HOME)/data/hosts.backup; sudo echo '127.0.0.1 $(DOMAIN_NAME)' >> /etc/hosts; fi"
	
$(NAME): prep
	@sudo docker compose -f srcs/$(DOCKER_COMPOSE_FILE) up --build -d

re: fclean all

clean:
	@sudo docker compose -f srcs/$(DOCKER_COMPOSE_FILE) -v down

fclean: clean
	@bash -c 'if [ -f $(USER_HOME)/data/hosts.backup ]; then sudo cp $(USER_HOME)/data/hosts.backup /etc/hosts; sudo rm -f $(USER_HOME)/data/hosts.backup; fi'
	@bash -c 'if [ -d $(USER_HOME)/data/mariadb ]; then sudo rm -rf $(USER_HOME)/data/mariadb; fi'
	@bash -c 'if [ -d $(USER_HOME)/data/wordpress ]; then sudo rm -rf $(USER_HOME)/data/wordpress; fi'
	@bash -c 'if [ "$$(ls $(USER_HOME)/data/ | wc -l)" -eq 0]; then rm -rf $(USER_HOME)/data; fi'

.PHONY = generate_certs prep re clean fclean 
