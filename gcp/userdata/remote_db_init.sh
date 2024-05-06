#!/bin/bash

## Download Kasm
cd /tmp
wget ${KASM_DOWNLOAD_URL}
tar xvf kasm_*.tar.gz

## Create swap partition
fallocate -l 2g /mnt/kasm.swap
chmod 600 /mnt/kasm.swap
mkswap /mnt/kasm.swap
swapon /mnt/kasm.swap
echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab

## Install useful packages
apt update && apt install iputils-ping dnsutils netcat -y

## Ensure connection to remote database before installing
while ! nc -w 1 -z ${DATABASE_IP} 5432
do
    echo "Waiting for DB connection..."
    sleep 10
done

## Ensure connection to remote Redis before installing
while ! nc -w 1 -z ${REDIS_IP} 6379
do
    echo "Waiting for Redis connection..."
    sleep 10
done

## Install Kasm
## Kasm install arguments used:
##  -S = Kasm role - init_remote_db in this case
##  -H = Don't check for swap (since we created it already)
##  -e = accept EULA
##  -q = Database IP or Hostname
##  -Q = Database password
##  -o = Redis IP or Hostname
##  -R = Redis password
##  -U = Password to use for user@kasm.local built-in account
##  -P = Password to use for admin@kasm.local built-in admin account
##  -M = Management token to use for agent registration
##  -k = Service registration token to use for Connection Proxy (Guac) registration
##  Useful additional arguments:
##   -O = use Rolling images (ensures the most up-to-date containers are used)
bash kasm_release/install_dependencies.sh
bash kasm_release/install.sh -S init_remote_db -e -H -q ${DATABASE_IP} -Q ${KASM_DB_PASS} -U ${KASM_USER_PASS} -P ${KASM_ADMIN_PASS} -o ${REDIS_IP} -R ${KASM_REDIS_PASS} -M ${KASM_SERVICE_TOKEN} -g ${DB_MASTER_USER} -G ${DB_MASTER_PASSWORD} -k ${KASM_SERVICE_TOKEN} ${ADDITIONAL_DATABASE_INSTALL_ARGS}
