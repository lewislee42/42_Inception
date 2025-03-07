#!/bin/bash

wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --allow-root --path=/var/www/html/

wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root --path=/var/www/html/

wp user create $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=author --allow-root --path=/var/www/html/

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/1' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;listen.owner = www-data/listen.owner = www-data/1' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;listen.group = www-data/listen.group = www-data/1' /etc/php/7.4/fpm/pool.d/www.conf

mkdir /run/php

#/usr/sbin/php-fpm7.3 -F
tail -f /dev/null
