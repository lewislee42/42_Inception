

NAME = Inception
SRCDIR = srcs
DOCKER_COMPOSE_FILE = docker-compose.yml
SECRETS_FILES = secrets/dhparam.pem secrets/cert.pem secrets/cert.key
DOMAIN_NAME = lewis.42.fr


all: $(NAME)

prep: 
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
