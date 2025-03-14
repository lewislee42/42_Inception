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
SRCDIR = srcs
DOCKER_COMPOSE_FILE = docker-compose.yml
SECRETS_FILES = secrets/dhparam.pem secrets/cert.pem secrets/cert.key
DOMAIN_NAME = lewis.42.fr

all: $(NAME)

prep: 
	@bash -c "if [ ! -d ./secrets/.env ]; then echo 'Error: .env file not created in secrets folder'; false; fi"
	@bash -c "if [[ ! -f ./secrets/dhparam.pem || ! -f secrets/cert.pem || ! -f secrets/cert.key ]]; then rm secrets/dhparam.pem secrets/cert.pem secrets/cert.key secrets/cert.csr; openssl req -new -newkey rsa:2048 -nodes -keyout secrets/cert.key -out secrets/cert.csr -subj '/C=MY/ST=Selangor/L=Subang/O=My Company/OU=IT/CN=$(DOMAIN_NAME)'; openssl x509 -req -days 3650 -in secrets/cert.csr -signkey secrets/cert.key -out secrets/cert.pem; rm secrets/cert.csr; fi"
	@cp $(SECRETS_FILES) ./srcs/requirements/nginx/tools/
	@bash -c "if [ ! -d ~/data/mariadb ]; then mkdir ~/data/mariadb; fi"
	@bash -c "if [ ! -d ~/data/wordpress ]; then mkdir ~/data/wordpress; fi"
	@sudo bash -c "if ! grep -q '$(DOMAIN_NAME)' /etc/hosts; then sudo echo '127.0.0.1 $(DOMAIN_NAME)' >> /etc/hosts; fi"
	
$(NAME): prep
	@sudo docker compose -f $(SRCDIR)/$(DOCKER_COMPOSE_FILE) up --build -d

re: fclean all

clean:
	@sudo docker compose -f $(SRCDIR)/$(DOCKER_COMPOSE_FILE) -v down

fclean: clean
	@sudo rm -rf ~/data/mariadb/*
	@sudo rm -rf ~/data/wordpress/*


.PHONY = prep re clean fclean 
