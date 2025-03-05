#!/bin/bash

service mysql start

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > dbInit.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' ;" >> dbInit.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> dbInit.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASS' ;" >> dbInit.sql
echo "FLUSH PRIVILEGES; " >> dbInit.sql

mysql < dbInit.sql
kill $(cat /var/run/mysqld/mysqld.pid)
mysqld
