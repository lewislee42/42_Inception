#!/bin/bash

# download all the core wordpress
wp core download

# create the config file with our database
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb

# creates the admin user & sets-up the database with the tables and fields
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email

# create a user using the wordpress cli
wp user create $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=author
