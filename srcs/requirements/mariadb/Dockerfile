FROM debian:bullseye

# install mariadb
RUN apt-get update
RUN apt-get install mariadb-server -y

# create and change the permission for mysqld
RUN mkdir /var/run/mysqld
RUN chmod 0777 /var/run/mysqld

# copy our script & chande the permissions to allow it to run
# this script is for creating a init.sql
COPY ./tools/entrypoint.sh /
RUN chmod 0777 ./entrypoint.sh

# run our script
ENTRYPOINT ["/entrypoint.sh"]
