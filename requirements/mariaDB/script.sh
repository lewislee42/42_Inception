#!/bin/bash

service mysql start

echo "CREATE DATABASE IF NOT EXISTS $db_name ;" > dbInit.sql
echo "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pass' ;" >> dbInit.sql
echo "GRANT ALL PRIVILEGES ON $db_name TO '$db_user'@'%' ;" >> dbInit.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '123456' ;" >> dbInit.sql
echo "FLUSH PRIVILEGES;" >> dbInit.sql

mysql < dbInit.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
