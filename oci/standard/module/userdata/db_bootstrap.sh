#!/bin/bash
set -ex
echo "Starting Kasm Workspaces Install"

/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=${swap_size}
/sbin/mkswap /var/swap.1
chmod 600 /var/swap.1
/sbin/swapon /var/swap.1

echo '/var/swap.1 swap swap defaults 0 0' | tee -a /etc/fstab

cd /tmp

PRIVATE_IP=(`hostname -I | cut -d  ' ' -f1 |  tr -d '\\n'`)

wget  ${kasm_build_url} -O kasm_workspaces.tar.gz
tar -xf kasm_workspaces.tar.gz
bash kasm_release/install.sh -S db -e -Q ${database_password} -R ${redis_password} -U ${user_password} -P ${admin_password} -M ${manager_token}

echo "Done"

