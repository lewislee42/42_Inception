#!/bin/bash

su tempUser -c "/wp-install-script.sh"

/usr/sbin/php-fpm7.4 -F
