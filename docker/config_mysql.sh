#!/usr/bin/env bash

# Change MySQL root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'toor';"

# Give permissions
mysql --password=toor -e "grant all privileges on *.* to root@'localhost' with grant option;"

# Configure MySQL with default options
mysql_secure_installation -D --password=toor

# Start MySQL
service mysql start

# Create Dolibarr Database
# DROP DATABASE dolibarr;
mysql --password=toor -e "CREATE DATABASE IF NOT EXISTS dolibarr CHARACTER SET UTF8 COLLATE utf8_bin;"

# Create Dolibarr User
mysql --password=toor -e "CREATE USER 'dolibarruser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'P@ssw0rd';"

# Grant privileges to Dolibarr user on Dolibarr DB
mysql --password=toor -e "GRANT ALL PRIVILEGES ON dolibarr.* TO 'dolibarruser'@'localhost' WITH GRANT OPTION;"
