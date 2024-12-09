#!/usr/bin/env bash


#######################
# Variables
#######################

DB_USER="dolidbuser"
DB_PASS="dolidbpass"
DB_HOST="dolibarr_db_sae_cambonsahuc"
DB_NAME="dolidb"
DOLIBARR_CONTAINER="dolibarr_web_sae_cambonsahuc"

DUMP_NAME="dump_database_$(date "+%Y%m%d_%H%M")"
DUMP_COMPRESS=false

HOST_USER_ID=$(id -u)
HOST_GROUP_ID=$(id -g)


#######################
# Dump database
#######################

echo "Dumping database: $DB_NAME"

if [ $DUMP_COMPRESS == true ]; then
    echo "Using bzip2 compression."

    COMPRESS_FLAG="| bzip2"
    FILENAME="$DUMP_NAME.sql.bz2"
else
    COMPRESS_FLAG=""
    FILENAME="$DUMP_NAME.sql"
fi

sudo docker exec \
    $DOLIBARR_CONTAINER \
    bash -c \
        "/usr/bin/mysqldump \
        --databases $DB_NAME \
        -h $DB_HOST \
        -u $DB_USER \
        -p$DB_PASS \
        --protocol=tcp \
        --single-transaction \
        --quick \
        --add-drop-table=TRUE \
        --tables -c -e \
        --hex-blob \
        --default-character-set=utf8mb4 \
        --no-tablespaces $COMPRESS_FLAG > /backups/$FILENAME" \
    && echo "Success: Saved file to $FILENAME" || echo "Error: Dump failed!"


##############################################################
# Change ownership from `root` to current user id:gid
##############################################################

sudo docker exec \
    $DOLIBARR_CONTAINER \
    bash -c \
    "chown -R $HOST_USER_ID:$HOST_GROUP_ID /backups/"