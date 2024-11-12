#!/usr/bin/env bash

# Change MySQL root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'toor';"

# Give permissions
mysql --password=toor -e "grant all privileges on *.* to root@'localhost' with grant option;"

# Configure MySQL with default options
mysql_secure_installation -D --password=toor
