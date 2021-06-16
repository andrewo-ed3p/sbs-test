#!/bin/sh
#

/usr/sbin/nginx -g "daemon off; error_log /dev/stderr info;" & docker-php-entrypoint php-fpm

