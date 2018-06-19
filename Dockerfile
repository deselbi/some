#start with our base image (the foundation) - version 7.2
FROM php:7.2.6-apache-stretch

#install all the system dependencies and enable PHP modules
RUN apt-get update && apt-get install -y \
      libicu-dev \
      libpq-dev \
      libmcrypt-dev \
      git \
      zip \
      unzip

RUN rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"

RUN docker-php-ext-install \
      intl \
      mbstring \
#      mcrypt \
      pcntl \
      pdo_mysql \
      pdo_pgsql \
      pgsql

RUN docker-php-ext-install \
#      zip \
      opcache


RUN pecl install mcrypt-1.0.1
RUN docker-php-ext-enable mcrypt

#install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

