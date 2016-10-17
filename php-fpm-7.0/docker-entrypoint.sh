#!/bin/sh
set -e

if [ -n "$PHP_CUSTOM_CONFIG" ];then
    echo "$PHP_CUSTOM_CONFIG" > /usr/local/etc/php/conf.d/docker-php-app-custom.ini
fi 

if [ -n "$PHP_FPM_CUSTOM_CONFIG" ];then
    echo "$PHP_FPM_CUSTOM_CONFIG" >> /usr/local/etc/php-fpm.d/zz-docker.conf
fi 

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- php-fpm "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'php-fpm' -a "$(id -u)" = '0' ]; then
	chown -R www-data:www-data /www/web
	chown -R www-data:www-data /www/log
	chown -R www-data:www-data /phmsdata
fi

exec "$@"
