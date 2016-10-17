#!/bin/sh
set -e

if [ -n "$PHP_CUSTOM_CONFIG" ];then
    echo "$PHP_CUSTOM_CONFIG" > /usr/local/etc/php/conf.d/docker-php-app-custom.ini
fi 

# first arg is `-c` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- supervisord "$@"
fi

exec "$@"
