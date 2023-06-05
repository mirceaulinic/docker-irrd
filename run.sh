#!/bin/sh

mkdir -p /var/cache/gnupg-keyring/
cp /tmp/gpg_private_key /var/cache/gnupg-keyring/irrd.key
chmod 600 /var/cache/gnupg-keyring/irrd.key

gpg --import /var/cache/gnupg-keyring/irrd.key

sed -i "s/IRRD_DATABSE_URL/$IRRD_DATABSE_URL/g" /etc/irrd.yaml

mkdir /var/run/irrd
chown daemon:daemon /var/run/irrd

/opt/pypy/bin/irrd_database_upgrade --config=/etc/irrd.yaml

exec /opt/pypy/bin/irrd --foreground --config=/etc/irrd.yaml
