#!/usr/bin/env bash

cd /var/www/html

git clone --depth 1 -b 20.0 http://github.com/Dolibarr/dolibarr.git dolibarr

chown -R www-data.www-data /var/www/html/dolibarr


