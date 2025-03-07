#!/bin/bash

# change the configurations for mariadb
sed -i "s/\= mysql/\= root/1" /etc/mysql/mariadb.conf.d/50-server.cnf # could be a security risk
sed -i "s/\= 127\.0\.0\.1/\= 0\.0\.0\.0/1" /etc/mysql/mariadb.conf.d/50-server.cnf # could be a security risk

# start mariadb
service mariadb start

# creates a script that will initialize the database
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > dbInit.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' ;" >> dbInit.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> dbInit.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '123456' ;" >> dbInit.sql
echo "FLUSH PRIVILEGES; " >> dbInit.sql

# runs the script
mariadb < dbInit.sql

# restarts mariadb but runs it in forground afterwards
kill $(cat /var/run/mysqld/mysqld.pid)
mysqld
