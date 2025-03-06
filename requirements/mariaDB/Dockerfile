FROM debian:bullseye

# install mariadb
RUN apt-get update -y && apt-get install mariadb-server -y && rm -rf /var/lib/apt/lists/*

# copy our script to create our init.sql
COPY ./scripts/entrypoint.sh /

# copy over our configuration
#COPY ./scripts/50-server.cnf /etc/mysql/mariadb.conf.d/

# create a directory for mysqld to run
RUN mkdir /var/run/mysqld

# change the permission just 
RUN chmod 0777 /var/run/mysqld

# change the permission of our script so it can run
RUN chmod 0777 ./entrypoint.sh

# run our script
CMD ["/entrypoint.sh"]

