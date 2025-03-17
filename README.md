# Inception (42)

# About this project
This project is about creating a dockerized environment running mariadb, wordpress & nginx, where the only exposed port is 443 through nginx.
This project expects you to run it on a linux machine.

# Requirements
Since we are using dockers for this project please make sure to install dockers following these instruction[https://docs.docker.com/engine/install/]
Make sure to run `cat .env.example > .env` and then fill out the env
Also change the domain name in the `Makefile` to match the one you entered in the env

# How to run
If all the requirements are met, all you have to do now is go to the root directory where this readme is in, and run `make Inception`, it will prompt you for your sudo password as it needs permission to run the docker and change a file on the host machine
Then afterwards (after its done building) all you have to do to see the website is go to the url `https://{DOMAIN_NAME}` and you should see the default page that wordpress serves. (DOMAIN_NAME being the one you entered in the)

# Other make commands
- `all`: Calls `Inception`
- `Inception`: Calls `prep` all which does the setup for the ssl certificates & appends domain name to the `/etc/hosts` file to make it accessible using the url `https://{DOMAIN_NAME}` (P.S you technically can access it using localhost as well :p )
- `generate_cert`: Generates all the certs/keys required for this project to be served using https
- `prep`: Calls `generate_certs` & creates directories that are used for this project & does the appending of the `DOMAIN_NAME` to the `/etc/hosts` file (this command will also warn you if you have not created a env file)
- `fclean`: Calls clean & deletes the directories that were created for the project
- `clean`: It runs the command `docker comopse -f ./srcs/docker-compose.yml -v down` which clears all the volumes created for the docker environment and shuts all the docker containers down
- `re`: Calls `fclean` then `all` afterwards
