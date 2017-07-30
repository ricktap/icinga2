#!/usr/bin/env bash
set -e

if [ ! -f /webconfig/setup.token ]; then
    echo "creating new setup token "
    /webconfig/bin/icingacli setup token create
    chgrp icingaweb2 /webconfig/setup.token
else
    echo "this is your setup token: "
    /opt/icingaweb2/bin/icingacli setup token show
fi

/etc/init.d/php5-fpm start
exec /etc/init.d/nginx start
