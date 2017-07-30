#!/usr/bin/env bash
set -e

ROOT_PASS=password
USER=icinga
PASS=icinga
DB=icinga

mysql -h mysql -u root --password=${ROOT_PASS} -e \
    "CREATE DATABASE IF NOT EXISTS ${DB};"
mysql -h mysql -u root --password=${ROOT_PASS} -e \
    "GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON ${DB}.* TO '${USER}' IDENTIFIED BY '${PASS}';"

# only run the migration, if the tables to not exist (the icinga mysql scripts are not idempotent)
if [[ ! $(mysql -h mysql -u root --password=${ROOT_PASS} -e "desc ${DB}.icinga_servicedependencies" > /dev/null 2>&1) -eq "0" ]]; then
    mysql -h mysql -u root --password=${ROOT_PASS} ${DB} < /share/icinga2-ido-mysql/schema/mysql.sql
fi
