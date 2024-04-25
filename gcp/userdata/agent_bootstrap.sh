#!/bin/bash

## Download Kasm
cd /tmp
wget ${KASM_DOWNLOAD_URL}
tar xvf kasm_*.tar.gz

## Create Swap partition
fallocate -l 8g /mnt/kasm.swap
chmod 600 /mnt/kasm.swap
mkswap /mnt/kasm.swap
swapon /mnt/kasm.swap
echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab
apt update && apt install iputils-ping dnsutils netcat -y

## Verify connectivity with the webapp private load balancer
while ! (curl -k https://${PRIVATE_LB_HOSTNAME}/api/__healthcheck 2>/dev/null | grep -q true)
do
    echo "Waiting for API server..."
    sleep 5
done

## Get Agent Private IP for Kasm registration
connect_ip="`hostname -I | cut -d' ' -f1`"

## Install Kasm
## Kasm install arguments used:
##  -S = Kasm role - agent in this case
##  -H = Don't check for swap (since we created it already)
##  -e = accept EULA
##  -p = Agent IP address or hostname
##  -m = Webapp private load balancer hostname
##  -M = Manager token to use to register the agent
##  Useful additional arguments:
##   -O = use Rolling images (ensures the most up-to-date containers are used)
bash kasm_release/install.sh -S agent -H -e -p $${connect_ip} -m ${PRIVATE_LB_HOSTNAME} -M ${KASM_MANAGER_TOKEN} ${ADDITIONAL_AGENT_INSTALL_ARGS}

## Install Nvidia drivers if this is a GPU-enabled agent.
if [[ "${GPU_ENABLED}" == "1" ]]
then
    apt-get update && apt-get upgrade -y
    apt-get install -y gcc make linux-headers-$(uname -r) linux-aws awscli
    cat << EOF | tee --append /etc/modprobe.d/blacklist.conf
blacklist vga16fb
blacklist nouveau
blacklist rivafb
blacklist nvidiafb
blacklist rivatv
EOF
    echo 'GRUB_CMDLINE_LINUX="rdblacklist=nouveau"' | tee --append /etc/default/grub
    update-grub
    aws s3 cp --no-sign-request --recursive s3://ec2-linux-nvidia-drivers/latest/ .
    chmod +x NVIDIA-Linux-x86_64*.run
    /bin/sh ./NVIDIA-Linux-x86_64*.run -s
    curl -fsSL "https://nvidia.github.io/nvidia-docker/gpgkey" | gpg --dearmor | tee /etc/apt/trusted.gpg.d/nvidia.gpg > /dev/null
    curl -s -L "https://nvidia.github.io/nvidia-docker/$(source /etc/os-release;echo $ID$VERSION_ID)/nvidia-docker.list" -o /etc/apt/sources.list.d/nvidia-docker.list
    apt-get update
    apt-get install -y nvidia-docker2
    systemctl restart docker
    docker restart kasm_agent
fi
