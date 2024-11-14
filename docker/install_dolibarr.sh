#!/usr/bin/env bash

cd /var/www/html

# Get the application from git repository
git clone --depth 1 -b 20.0 https://github.com/Dolibarr/dolibarr.git dolibarr

# Change permissions and owner of the 'dolibarr' directory
chown -R www-data.www-data /var/www/html/dolibarr

# create empty configuration file
cd dolibarr ; touch htdocs/conf/conf.php ; chown www-data htdocs/conf/conf.php

# directory that will be used to save all files generated and stocked by Dolibarr (PDf invoices, uploaded images, ...)
mkdir -p /var/lib/dolibarr/documents ; chown www-data /var/lib/dolibarr/documents

# lock the call of the install process again
touch /var/lib/dolibarr/documents/install.lock; chmod go-w /var/lib/dolibarr/documents
