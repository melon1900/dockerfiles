FROM php:7.0-cli

RUN set -xe && \
    apt-get update && apt-get install -y \
        python-setuptools git unzip \
        libmcrypt-dev \
        libmhash-dev \
        libcap-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt mysqli pdo pdo_mysql sockets \
    && rm -r /var/lib/apt/lists/* \
    && easy_install supervisor

COPY docker-entrypoint.sh /usr/local/bin/                                                                                                                                                            

ENTRYPOINT ["docker-entrypoint.sh"]                                                                                                                                                                  

CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]