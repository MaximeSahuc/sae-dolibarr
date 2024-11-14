
/usr/bin/mysqldump dolibarr -h mariadb -u root -P 3306 \
    --protocol=tcp --single-transaction --quick --add-drop-table=TRUE \
    --tables -c -e --hex-blob --default-character-set=utf8mb4 --no-tablespaces -proot \
    >>dumpdatabase_$(date "+%Y%m%d").sql

echo "dumpdatabase_$(date "+%Y%m%d").sql" > latest