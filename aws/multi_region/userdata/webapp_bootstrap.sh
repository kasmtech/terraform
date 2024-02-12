#!/bin/bash
set -ex
echo "Starting Kasm Workspaces Install"

/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=${swap_size}
/sbin/mkswap /var/swap.1
chmod 600 /var/swap.1
/sbin/swapon /var/swap.1

echo '/var/swap.1 swap swap defaults 0 0' | tee -a /etc/fstab

cd /tmp

wget  ${kasm_build_url} -O kasm_workspaces.tar.gz
tar -xf kasm_workspaces.tar.gz

echo "Checking for Kasm DB and Redis..."
apt-get update && apt-get install -y netcat
while ! nc -w 1  -z ${db_ip} 5432; do
  echo "Database not ready..."
  sleep 5
done
echo "DB is alive"

while ! nc -w 1  -z ${db_ip} 6379; do
  echo "Redis not ready..."
  sleep 5
done
echo "Redis is alive"


bash kasm_release/install.sh -S app -e -z ${zone_name} -q "${db_ip}" -Q ${database_password} -R ${redis_password}

echo "Done"
