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
apt update && apt install iputils-ping dnsutils netcat -y

## Make sure the CPX node can access the private load balancer
while ! (curl -k https://${PRIVATE_LB_HOSTNAME}/api/__healthcheck 2>/dev/null | grep -q true)
do
    echo "Waiting for API server..."
    sleep 5
done

## Get CPX Private IP for Kasm registration
connect_ip="`hostname -I | cut -d' ' -f1`"

## Install Kasm
## Kasm install arguments used:
##  -S = Kasm role - guac in this case
##  -H = Don't check for swap (since we created it already)
##  -e = accept EULA
##  -n = Private Load balancer URL for Kasm webapps
##  -p = CPX Node private IP so webapp can connect to CPX
##  -k = Service registration token required to register the CPX with Kasm
##  -z = The Zone name to register the CPX node with
##  Useful additional arguments:
##   -O = use Rolling images (ensures the most up-to-date containers are used)
bash kasm_release/install.sh -S guac -H -e -n ${PRIVATE_LB_HOSTNAME} -p $${connect_ip} -k ${KASM_SERVICE_TOKEN} -z ${KASM_ZONE_NAME} ${ADDITIONAL_CPX_INSTALL_ARGS}
