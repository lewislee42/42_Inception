

NAME = Inception
SRCDIR = srcs
DOCKER_COMPOSE_FILE = docker-compose.yml
SECRETS_FILES = dhparam.pem cert.pem cert.key


all: $(NAME)

prep: 
	@bash -c "if [ ! -d ~/data/mariadb ]; then mkdir ~/data/mariadb; fi"
	@bash -c "if [ ! -d ~/data/wordpress ]; then mkdir ~/data/wordpress; fi"
	
$(NAME): prep
	@sudo docker compose -f $(SRCDIR)/$(DOCKER_COMPOSE_FILE) up --build -d

clean:
	@sudo docker comopose -f $(SRCDIR)/$(DOCKER_COMPOSE_FILE) down

fclean: clean
	@sudo rm -rf ~/data/mariadb/* && sudo rm -rf ~/data/wordpress/*
	@cp $(SECRETS_FILES) ./srcs/requirements/nginx/tools/


.PHONY = prep fclean clean run
