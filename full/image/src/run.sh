#!/usr/bin/env bash
set -e

if [ ! -f /etc/icingaweb2/setup.token ]; then
    echo "creating new setup token "
    /opt/icingaweb2/bin/icingacli setup token create
else
    echo "this is your setup token: "
    /opt/icingaweb2/bin/icingacli setup token show
fi

/etc/init.d/php5-fpm start
exec /etc/init.d/nginx start
