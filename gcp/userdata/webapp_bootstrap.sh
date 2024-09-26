#!/bin/bash

## Download Kasm
cd /tmp
wget ${KASM_DOWNLOAD_URL}
tar xvf kasm_*.tar.gz

## Create Swap partition
fallocate -l 2g /mnt/kasm.swap
chmod 600 /mnt/kasm.swap
mkswap /mnt/kasm.swap
swapon /mnt/kasm.swap
echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab

## Install useful packages
apt update && apt install iputils-ping dnsutils netcat-openbsd -y

## Test Database connectivity before installing
while ! nc -w 1 -z ${DB_PRIVATE_IP} 5432
do
    echo "Waiting for DB connection..."
    sleep 5
done

## Test Redis connectivity before installing
while ! nc -w 1 -z ${DB_PRIVATE_IP} 6379
do
    echo "Waiting for Redis connection..."
    sleep 5
done

## Install Kasm
## Kasm install arguments used:
##  -S = Kasm role - webapp in this case
##  -H = Don't check for swap (since we created it already)
##  -e = accept EULA
##  -q = Database Server IP
##  -Q = Database password
##  -R = Redis password
##  -z = The Zone name to use for the webapp
## Useful additional arguments:
##  -O = use Rolling images (ensures the most up-to-date containers are used)
bash kasm_release/install.sh -S app -H -e -z ${KASM_ZONE_NAME} -q ${DB_PRIVATE_IP} -Q ${KASM_DB_PASS} -R ${KASM_REDIS_PASS} ${ADDITIONAL_WEBAPP_INSTALL_ARGS}
