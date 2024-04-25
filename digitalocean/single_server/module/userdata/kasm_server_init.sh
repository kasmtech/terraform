#!/bin/bash
set -ex
echo "Starting Kasm Workspaces Install"

## Create Swap partition
fallocate -l "${swap_size}"g /var/kasm.swap
chmod 600 /var/kasm.swap
mkswap /var/kasm.swap
swapon /var/kasm.swap
echo '/var/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab

cd /tmp

PRIVATE_IP=(`hostname -I | cut -d' ' -f1 | tr -d '\\n'`)

wget  ${kasm_build_url} -O kasm_workspaces.tar.gz
tar -xf kasm_workspaces.tar.gz
bash kasm_release/install.sh -e -U ${user_password} -P ${admin_password} -p $PRIVATE_IP -m $PRIVATE_IP

echo "Done
