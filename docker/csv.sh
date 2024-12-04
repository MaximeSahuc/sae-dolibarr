#!/usr/bin/env bash

mysql -e "LOAD DATA INFILE 'test-import.csv' INTO TABLE llx_facture \
  FIELDS TERMINATED BY ',' ENCLOSED BY '"' \
  LINES TERMINATED BY '\r\n' \
  IGNORE 1 LINES;"