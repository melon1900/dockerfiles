FROM php:5.6-fpm

MAINTAINER Melon Li <melon198502@gmail.com>

RUN set -xe && \
	apt-get update && apt-get install -y \
        libmcrypt-dev \
        libmhash-dev \
        libcap-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        && rm -r /var/lib/apt/lists/* \
        && docker-php-ext-install -j$(nproc) iconv mcrypt mysqli pdo pdo_mysql sockets opcache \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
        && pecl install redis-2.2.8 \
        && docker-php-ext-enable redis \
        && mkdir -p /www/web /phmsdata

COPY ioncube.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm"]
