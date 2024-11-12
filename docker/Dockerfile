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
    && apt-get clean

# Install Apache2
RUN apt install -y \
    apache2

# Enable Apache modules
RUN a2enmod rewrite

# Expose HTTP port
EXPOSE 80

# Start Apache
CMD apache2ctl -D FOREGROUND
