#!/usr/bin/env bash

# Change MySQL root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'toor';"

# Configure MySQL with default options
mysql_secure_installation -D -password=toor
