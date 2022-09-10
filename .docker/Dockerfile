FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install software-properties-common -yq
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -yq --no-install-recommends \
	apt-utils curl git \
	# Install apache
	apache2 libapache2-mod-php8.1 \
	# Install PHP 8.1
	php8.1-cli php-json php8.1-curl \
	php8.1-fpm php8.1-gd php8.1-ldap php8.1-apcu \
	php8.1-mbstring php8.1-mysql php8.1-soap \
	php8.1-sqlite3 php8.1-xml php8.1-zip \
	php8.1-intl php-imagick php-memcache \
	php-pear libjpeg-dev \
	# Install tools
	openssl locales \
	mysql-client \
	ca-certificates

RUN apt-get install -y mysql-client curl git tig vim nano wget tree unzip gnupg2 patch

# Install composer
RUN wget -q https://getcomposer.org/composer-1.phar -O composer && \
	chmod +x composer && \
	mv composer /usr/local/bin
RUN composer global require hirak/prestissimo

# Install Drush
RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.4.2/drush.phar && \
	chmod +x drush.phar && \
	mv drush.phar /usr/local/bin/drush

# Set locales
RUN locale-gen pt_BR.UTF-8 en_US.UTF-8 en_GB.UTF-8

RUN a2enmod rewrite headers ssl include proxy_fcgi setenvif
RUN a2enconf php8.1-fpm
RUN systemctl enable php8.1-fpm

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get upgrade -y --fix-missing
RUN apt-get install -y nodejs
RUN apt-get install -y software-properties-common
RUN apt-get install -y libmcrypt-dev libzip-dev libjpeg-dev

RUN npm install -g yarn gulp gulp-cli

RUN rm -rf /var/www/html/*

COPY .docker/apache-drupal.conf /etc/apache2/sites-enabled/000-default.conf

COPY .docker/opcache.ini /etc/php/8.1/apache2/conf.d/
COPY .docker/php.ini /etc/php/8.1/apache2/conf.d

RUN echo 'change 04'

WORKDIR /app/drupal

RUN composer create-project drupal/recommended-project:^9.4 .

CMD service php8.1-fpm start;apachectl -D FOREGROUND
