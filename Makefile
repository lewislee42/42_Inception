

NAME = Inception
SRCDIR = srcs
DOCKER_COMPOSE_FILE = docker-compose.yml
SECRETS_FILES = secrets/dhparam.pem secrets/cert.pem secrets/cert.key


all: $(NAME)

prep: 
	@cp $(SECRETS_FILES) ./srcs/requirements/nginx/tools/
	@bash -c "if [ ! -d ~/data/mariadb ]; then mkdir ~/data/mariadb; fi"
	@bash -c "if [ ! -d ~/data/wordpress ]; then mkdir ~/data/wordpress; fi"
	
$(NAME): prep
	@sudo docker compose -f $(SRCDIR)/$(DOCKER_COMPOSE_FILE) up --build -d

re: fclean all

clean:
	@sudo docker compose -f $(SRCDIR)/$(DOCKER_COMPOSE_FILE) down

fclean: clean
	@sudo rm -rf ~/data/mariadb/* && sudo rm -rf ~/data/wordpress/*


.PHONY = prep re clean fclean 
