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

wget  ${kasm_build_url} -O kasm_workspaces.tar.gz
tar -xf kasm_workspaces.tar.gz

echo "Checking for Kasm DB and Redis..."
apt-get update && apt-get install -y netcat-openbsd
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


bash kasm_release/install.sh -S app -e -H -z ${zone_name} -q "${db_ip}" -Q ${database_password} -R ${redis_password}

echo "Done"
