#!/bin/bash
set -ex
echo "Starting Kasm Workspaces Install"

/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=${swap_size}
/sbin/mkswap /var/swap.1
chmod 600 /var/swap.1
/sbin/swapon /var/swap.1

cd /tmp

PRIVATE_IP=(`hostname -I | cut -d ' ' -f1 | tr -d '\\n'`)

wget  ${kasm_build_url} -O kasm_workspaces.tar.gz
tar -xf kasm_workspaces.tar.gz
bash kasm_release/install.sh -e -U ${user_password} -P ${admin_password} -p $PRIVATE_IP -m $PRIVATE_IP

echo -e "${nginx_cert_in}" > /opt/kasm/current/certs/kasm_nginx.crt
echo -e "${nginx_key_in}" > /opt/kasm/current/certs/kasm_nginx.key

echo "Stopping and restarting Kasm services to apply certificates..."
/opt/kasm/bin/stop
docker rm $(docker ps -aq)
/opt/kasm/bin/start

echo "Done"
