#!/usr/bin/env bash


DB_USER="root"
DB_PASS="root"
DB_HOST="dolibarr_mariadb"
DB_NAME="dolibarr"
DOLIBARR_CONTAINER="dolibarr_web"

# sudo docker exec \
#     $DOLIBARR_CONTAINER \
#     bash -c \
#         "mysql \
#         --database $DB_NAME \
#         -h $DB_HOST \
#         -u $DB_USER \
#         -p$DB_PASS \
#         -e "LOAD DATA INFILE '/root/test-import.csv' INTO TABLE llx_facture \
#         FIELDS TERMINATED BY ',' ENCLOSED BY '"' \
#         LINES TERMINATED BY '\r\n' \
#         IGNORE 1 LINES;""

sudo docker exec \
    $DOLIBARR_CONTAINER \
    bash -c "mysql \
    --database dolibarr \
    -h dolibarr_mariadb \
    -u root \
    -proot \
    -e "LOAD DATA LOCAL INFILE '/root/csv_import/test-import.csv' INTO TABLE llx_user \
    FIELDS TERMINATED BY ',' ENCLOSED BY '\"' \
    LINES TERMINATED BY '\n' IGNORE 1 LINES;""