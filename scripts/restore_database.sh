#!/usr/bin/env bash


#######################
# Variables
#######################

DB_USER="dolidbuser"
DB_PASS="dolidbpass"
DB_HOST="dolibarr_db_sae_cambonsahuc"
DB_NAME="dolidb"
DOLIBARR_CONTAINER="dolibarr_web_sae_cambonsahuc"


if [[ $# -ne 1 ]]; then  # if less than 2 arguments are provided, display help message
    echo "Error: Please provide the SQL dump file path as argument."
    echo "Example: ./restore_database.sh <dump.sql>"
    exit 1
fi


#######################
# Restore database
#######################

DUMP_NAME=$(basename $1)  # get file name instead of relative path
echo "Restoring database from $DUMP_NAME"

sudo docker exec \
    $DOLIBARR_CONTAINER \
    bash -c \
        "mysql \
        --database $DB_NAME \
        -h $DB_HOST \
        -u $DB_USER \
        -p$DB_PASS \
        < /backups/$DUMP_NAME" \
    && echo "Success: database retored from $DUMP_NAME" || echo "Error: retore failed!"
