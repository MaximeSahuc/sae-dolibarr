#!/usr/bin/env bash


DB_USER="root"
DB_PASS="root"
DB_HOST="dolibarr_mariadb"
DB_NAME="dolibarr"
DOLIBARR_CONTAINER="dolibarr_web"

sudo docker exec \
    $DOLIBARR_CONTAINER \
    bash -c "mysql \
    --database $DB_NAME \
    -h $DB_HOST \
    -u $DB_USER \
    -p$DB_PASS \
    < /root/csv_import/import.sql"