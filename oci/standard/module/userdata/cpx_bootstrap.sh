#!/bin/bash
set -ex
echo "Starting Kasm Workspaces Agent Install"

## Create Swap partition
fallocate -l "${swap_size}"g /var/kasm.swap
chmod 600 /var/kasm.swap
mkswap /var/kasm.swap
swapon /var/kasm.swap
echo '/var/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab

cd /tmp

PRIVATE_IP=(`hostname -I | cut -d  ' ' -f1 |  tr -d '\\n'`)

wget  ${kasm_build_url} -O kasm_workspaces.tar.gz
tar -xf kasm_workspaces.tar.gz

echo "Waiting for Kasm WebApp availability..."
while ! (curl -k https://${manager_address}/api/__healthcheck 2>/dev/null | grep -q true)
do
  echo "Waiting for API server..."
  sleep 5
done
echo "WebApp is alive"

bash kasm_release/install.sh -S guac -e -p $PRIVATE_IP -n ${manager_address} -k ${service_registration_token}

echo "Done"
