FROM docker.io/library/php:8-apache

WORKDIR /var/www/html

# https://www.php.net/manual/en/image.installation.php
RUN apt-get update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev iputils-ping docker.io\
 && docker-php-ext-configure gd --with-jpeg --with-freetype \
 # Use pdo_sqlite instead of pdo_mysql if you want to use sqlite
 && docker-php-ext-install gd mysqli pdo pdo_mysql

RUN apt install -y netcat-openbsd ncat openssh-server

RUN echo 'root:you_ve_been_hacked' | chpasswd
RUN mkdir -p /run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY --chown=www-data:www-data . .
COPY --chown=www-data:www-data config/config.inc.php.dist config/config.inc.php

RUN usermod -aG docker www-data
RUN newgrp docker

EXPOSE 22

COPY init_infinite.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh
