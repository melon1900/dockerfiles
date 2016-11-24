FROM php:7.0-cli

MAINTAINER Melon Li <melon198502@gmail.com>

RUN set -xe && \
    apt-get update && apt-get install -y \
        ca-certificates \
        libmcrypt-dev \
        libmhash-dev \
        libcap-dev \
        openssh-server \
        supervisor \
        wget \
    && docker-php-ext-install -j$(nproc) iconv mcrypt mysqli pdo pdo_mysql sockets \
    && rm -r /var/lib/apt/lists/*
    
COPY ioncube.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012/
RUN set -xe && docker-php-ext-enable ioncube 

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.9
RUN set -x \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

RUN mkdir -p /www/log/jobs /www/web/queue

COPY docker-entrypoint.sh /usr/local/bin/                                                                                                                                                            
COPY supervisord.conf /etc/supervisor/supervisord.conf                                                                                                                                                           

ENTRYPOINT ["docker-entrypoint.sh"]                                                                                                                                                                  

CMD ["supervisord"]
