#!/bin/sh
set -e

# first arg is `-c` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- supervisord "$@"
fi

# allow the container to be started with www-data
if [ "$1" = 'supervisord' -a "$(id -u)" = '0' ]; then
    if [ -n "$PHP_CUSTOM_CONFIG" ];then
        echo "$PHP_CUSTOM_CONFIG" > /usr/local/etc/php/conf.d/docker-php-app-custom.ini
    fi

    chown -R www-data:www-data /www/log/jobs /www/web/queue
    exec gosu www-data "$0" "$@"
fi

exec "$@"
