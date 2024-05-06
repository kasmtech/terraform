#!/bin/bash

## Download Kasm
cd /tmp
wget ${KASM_DOWNLOAD_URL}
tar xvf kasm_*.tar.gz

## Create swap partition
fallocate -l 8g /mnt/kasm.swap
chmod 600 /mnt/kasm.swap
mkswap /mnt/kasm.swap
swapon /mnt/kasm.swap
echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab

## Install useful packages
apt update && apt install iputils-ping dnsutils netcat -y

## Install Kasm
## Kasm install arguments used:
##  -S = Kasm role - db in this case
##  -H = Don't check for swap (since we created it already)
##  -e = accept EULA
##  -Q = Database password
##  -R = Redis password
##  -U = Password to use for user@kasm.local built-in account
##  -P = Password to use for admin@kasm.local built-in admin account
##  -M = Management token to use for agent registration
##  -k = Service registration token to use for Connection Proxy (Guac) registration
##  Useful additional arguments:
##   -O = use Rolling images (ensures the most up-to-date containers are used)
bash kasm_release/install.sh -S db -e -Q ${KASM_DB_PASS} -R ${KASM_REDIS_PASS} -U ${KASM_USER_PASS} -P ${KASM_ADMIN_PASS} -M ${KASM_MANAGER_TOKEN} -k ${KASM_SERVICE_TOKEN} ${ADDITIONAL_DATABASE_INSTALL_ARGS}
