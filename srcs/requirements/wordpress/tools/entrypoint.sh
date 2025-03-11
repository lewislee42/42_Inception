#!/bin/bash

# go into the directory we want to download wordpress into
cd /var/www/html/

# create the config file with our database
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --allow-root --dbhost=mariadb

# install the wordpress website files
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# create a user using the wordpress cli
wp user create $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=author --allow-root

# modify the settings of the fpm
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/1' /etc/php/7.4/fpm/pool.d/www.conf

# make sure this directory exist so that php can run?
mkdir /run/php

# this makes it a forground process and not a daemon
/usr/sbin/php-fpm7.4 -F
#tail -f /dev/null
