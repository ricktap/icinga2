#!/usr/bin/env bash
set -e

HOST=${DB_HOST:mysql}

ROOT_PASS=${DB_ROOT_PASSWORD:password}
USER=${DB_ICINGA_USER:icinga}
PASS=${DB_ICINGA_PASSWORD:icinga}
DB=icinga

mysql -h ${HOST} -u root --password=${ROOT_PASS} -e \
    "CREATE DATABASE IF NOT EXISTS ${DB};"
mysql -h ${HOST} -u root --password=${ROOT_PASS} -e \
    "GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON ${DB}.* TO '${USER}' IDENTIFIED BY '${PASS}';"

# only run the migration, if the tables to not exist (the icinga mysql scripts are not idempotent)
if [[ ! $(mysql -h ${HOST} -u root --password=${ROOT_PASS} -e "desc ${DB}.icinga_servicedependencies" > /dev/null 2>&1) -eq "0" ]]; then
    mysql -h ${HOST} -u root --password=${ROOT_PASS} ${DB} < /share/icinga2-ido-mysql/schema/mysql.sql
fi
