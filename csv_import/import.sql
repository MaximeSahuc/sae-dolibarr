LOAD DATA LOCAL INFILE '/root/csv_import/test-import.csv' INTO TABLE llx_user \
    FIELDS TERMINATED BY ',' ENCLOSED BY '"' \
    LINES TERMINATED BY '\n' IGNORE 1 LINES;