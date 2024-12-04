FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Necessary packages
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    curl \
    vim \
    git \
    wget \
    iproute2 \
    && apt-get clean

# Install Apache2
RUN apt-get update && apt install -y \
    apache2

# Install PHP
RUN apt-get update && apt install -y \
    php \
    php-mysql \
    libapache2-mod-php

# Install PHP required extensions for Dolibarr
RUN apt-get update && apt install -y \
    php-mbstring \
    php-gd \
    php-curl \
    php-xml \
    php-intl \
    php-imap \
    php-zip

# Enable PHP extensions required by Dolibarr
RUN echo -e "extension=mbstring\nextension=gd\nextension=curl\nextension=xml\nextension=intl\nextension=imap\nextension=zip" >> /etc/php/7.4/apache2/php.ini

# Restart Apache2
RUN service apache2 restart

# Install MYSQL
RUN apt-get update && apt install -y \
    mysql-server

# Enable Apache modules
RUN a2enmod rewrite

# Configure MySQL
COPY ./config_mysql.sh .
RUN service mysql start && ./config_mysql.sh

# Install Dolibarr
COPY install_dolibarr.sh .
RUN ./install_dolibarr.sh

# Expose HTTP and MySQL ports
EXPOSE 80
EXPOSE 3306

# Start Apache
CMD service mysql start ; apache2ctl -D FOREGROUND
