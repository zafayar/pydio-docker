#!/bin/sh
set +e
# permissions
PUID=${PUID:-911}
PGID=${PGID:-911}

/usr/sbin/groupmod -g $PGID abc
/usr/sbin/usermod -u $PUID -g $PGID abc
[ -d /tmp/sess ] || mkdir /tmp/sess/
[ -d /var/www/pydio/data/cache ] || mkdir -p /var/www/pydio/data/cache
[ -d /var/www/pydio/data/logs ] || mkdir -p /var/www/pydio/data/logs
[ -d /var/www/pydio/data/personal ] || mkdir -p /var/www/pydio/data/personal
[ -d /var/www/pydio/data/public ] || mkdir -p /var/www/pydio/data/public
[ -d /var/www/pydio/data/files ] || mkdir -p /var/www/pydio/data/files
[ -d /var/www/pydio/data/tmp ] || mkdir -p /var/www/pydio/data/tmp
[ -d /data/pydio ] || mkdir -p /data/pydio
[ -d /data/booster ] || mkdir -p /data/booster
[ -f /data/booster/pydiocaddy.conf ] || cp /etc/pydiocaddy.conf /data/booster/pydiocaddy.conf
[ -f /data/booster/pydioconf.conf ] || cp /etc/pydioconf.conf /data/booster/pydioconf.conf
rm -Rf /var/www/pydio/data

ln -s /data/pydio /var/www/pydio/data
chown -Rf abc:abc /data
chown -Rf abc:abc /tmp/sess
chown -Rf abc:abc /var/www/pydio/data
chown -Rf abc:abc /var/www/pydio
chmod -R 770 /tmp/sess
chmod -R 700 /data/pydio


echo " Starting User uid: $(id -u abc), User gid:    $(id -g abc)"
set -e
