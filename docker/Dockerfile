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
RUN apt install -y \
    apache2

# Install PHP
RUN apt install -y \
    php \
    php-mysql \
    libapache2-mod-php

# Install MYSQL
RUN apt install -y \
    mysql-server

# Enable Apache modules
RUN a2enmod rewrite

# Expose HTTP and MySQL ports
EXPOSE 80
EXPOSE 3306

# Start Apache and MySQL
CMD service mysql start && apache2ctl -D FOREGROUND
