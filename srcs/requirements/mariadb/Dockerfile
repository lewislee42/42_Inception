FROM debian:bullseye

# install mariadb
RUN apt-get update
RUN apt-get install mariadb-server -y

# copy our script to create our init.sql
COPY ./tools/entrypoint.sh /

# create a directory for mysqld to run
RUN mkdir /var/run/mysqld

# change the permission just in case
RUN chmod 0777 /var/run/mysqld

# change the permission of our script so it can run
RUN chmod 0777 ./entrypoint.sh

# run our script
CMD ["/entrypoint.sh"]
