
fclean:
	sudo docker compose down && sudo rm -rf ~/data/mariadb/* && sudo rm -rf ~/data/wordpress/*

run:
	sudo docker compose up --build -d


.PHONEY=run fclean
