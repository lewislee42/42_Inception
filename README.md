# Inception (42)

# About this project
This project is about creating a dockerized environment running mariadb, wordpress & nginx, where the only exposed port is 443 through nginx.
This project expects you to run it on a linux machine.

# Requirements
First make sure that the machine that you want to run this project on is a linux machine (either by using virtualbox or your main machine but this is not recommended as it may change some files that you do not want changed)
After you have your linux installed you then have to install git & make & a text editor of your choice to edit the env (if you run into a user not in sudoers file error you can head here [user not in sudoers file])
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

# Things to that this project modifies in the machine that you are running it from
- This project appends the domain name specified in the project env into the `/etc/hosts` where the machine will query when you enter the url into a browser/curl, in doing so it will create a `/etc/hosts.backup` file that stores all the values it has before running `make prep`, this project will remove the line appended after running `make fclean`, if you for any reason lose the make file you can run `cp /etc/hosts.backup /etc/hosts` to copy the backup back into the hosts file (the `/etc/hosts.backup` file can be safely removed) 
- This project will also create 1 directory that has 2 subdirectories (1 for mariadb to store its files & 1 for wordpress & nginx to store and access the wordpress files) it will be located at `~/data`, this file should be deleted after you run make fclean

# Trouble shooting
- [#user not in sudoers file]: to solve this you have to first add user into the sudo group by running `su root -c "sudo usermod -aG sudo {your user here}"` then you have to run `su root -c "sudo visudo"` and nano (text editor) should open up, now all you need to do is add this line `{your user}    = ALL=(ALL) ALL` under the root user to allow your current user to run the sudo command.
