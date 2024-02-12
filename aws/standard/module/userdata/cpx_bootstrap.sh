#!/bin/bash
set -ex
echo "Starting Kasm Workspaces Agent Install"

/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=${swap_size}
/sbin/mkswap /var/swap.1
chmod 600 /var/swap.1
/sbin/swapon /var/swap.1

echo '/var/swap.1 swap swap defaults 0 0' | tee -a /etc/fstab

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

bash kasm_release/install.sh -S cpx -e -p $PRIVATE_IP -n ${manager_address} -k ${service_registration_token}

echo "Done"
