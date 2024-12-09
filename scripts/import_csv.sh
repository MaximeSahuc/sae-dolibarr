#!/usr/bin/env bash


#######################
# Variables
#######################

DB_USER="dolidbuser"
DB_PASS="dolidbpass"
DB_HOST="dolibarr_db_sae_cambonsahuc"
DB_NAME="dolidb"
DOLIBARR_CONTAINER="dolibarr_web_sae_cambonsahuc"


##############################
# Import data from CSV
##############################

sudo docker exec \
    $DOLIBARR_CONTAINER \
    bash -c "mysql \
    --database $DB_NAME \
    -h $DB_HOST \
    -u $DB_USER \
    -p$DB_PASS \
    < /root/csv_import/import.sql"