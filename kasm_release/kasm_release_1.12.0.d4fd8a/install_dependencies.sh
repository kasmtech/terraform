#!/usr/bin/env bash
set -e
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

OS_ID='unknown'
OS_VERSION_ID='unknown'
SUPPORTED='false'
INSTALL_COMPOSE='false'
INSTALL_DOCKER='false'
MIN_DOCKER_VERSION='18.06'
MIN_DOCKER_COMPOSE_VERSION='2.1.1'

CPU_ARCH="$(uname -i)"

function verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

# Checks if version $1 is less than $2
function verlt() {
    [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

function check_docker_dependencies (){
    echo "Checking if docker and docker compose are installed."
    set +e
    DOCKER_VERSION=$(docker system info | grep "Server Version" | awk '{ print $3 }')
    DOCKER="$(command -v docker)"
    DOCKER_COMPOSE="$(docker compose 2>/dev/null)"
    DOCKER_COMPOSE_VERSION="$( (docker compose version --short | sed s/v//g) 2>/dev/null)"
    set -e
    if [ -z "${DOCKER}" ] ; then
        INSTALL_DOCKER='true'
    else
        echo "Docker is installed"

        if [ -z "${DOCKER_VERSION}" ] ; then
            echo "Unable to check Docker version, is the Docker daemon running?"
            echo "Aborting Kasm Workspaces install."
            exit -1
        elif verlt "${DOCKER_VERSION}" "${MIN_DOCKER_VERSION}" ; then
            echo "The installed Docker Version: $DOCKER_VERSION is an unsupported version of Docker."
            echo "Aborting Kasm Workspaces install."
            exit -1
        else
            echo "$DOCKER_VERSION is a supported version of docker."
        fi
        
        
        if (docker system info | grep 'Docker Root Dir' | grep -q '/var/snap/docker') > /dev/null 2>&1 ; then
            echo "Detected version of Docker is installed via snap. This is unsupported."
            echo "Aborting Kasm Workspaces install."
            exit -1
        fi
    fi

    if [ -z "${DOCKER_COMPOSE}" ] ; then
        echo "Docker Compose is not installed."
        INSTALL_COMPOSE='true'
    else
        echo "Docker compose is installed"

        if [ -z "${DOCKER_COMPOSE_VERSION}" ] ; then
            echo "Unable to determine docker compose version"
            echo "Aborting workspaces install"
            exit -1
        elif verlt "${DOCKER_COMPOSE_VERSION}" "${MIN_DOCKER_COMPOSE_VERSION}" ; then
            echo "${DOCKER_COMPOSE_VERSION} is an old version of docker compose, installing a new version"
            INSTALL_COMPOSE='true'
        else
            echo "${DOCKER_COMPOSE_VERSION} is a supported version of docker compose"
        fi
    fi

    if [ "${INSTALL_DOCKER}" == 'false' ] && [ "${INSTALL_COMPOSE}" == 'false' ] ; then
        echo "Commands docker and docker compose detected."
        echo "Skipping Dependency Installation."
        exit 0
    fi
}

function install_docker_compose (){
   echo "Installing Docker Compose"
   mkdir -p /usr/local/lib/docker/cli-plugins
   curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/lib/docker/cli-plugins/docker-compose
   chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
}

function install_centos (){
    echo "CentOS 7.x/8.x/9.x Install"
    echo "Installing Base CentOS Packages"

    NO_BEST=""
    if [ "${1}" == '"8"' ] || [ "${1}" == '"9"' ]; then
        NO_BEST="--nobest"
    fi

    yum install -y yum-utils \
        device-mapper-persistent-data \
        lvm2 \
        lsof

    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo

    echo "Installing Docker-CE"
    yum install -y docker-ce $NO_BEST
    systemctl start docker
}


function install_ubuntu (){
    echo "Ubuntu 18.04/20.04/22.04 Install"
    echo "Installing Base Ubuntu Packages"
    apt-get update
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

    if dpkg -s docker-ce | grep Status: | grep installed ; then
      echo "Docker Installed"
    else
      echo "Installing Docker-CE"

      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      add-apt-repository -y "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      apt-get update
      apt-get -y install docker-ce
    fi
}

function install_debian (){
    echo "Debian 9.x/10.x/11.x Install"
    echo "Installing Base Debian Packages"
    apt-get update
    sudo apt-get install -y \
         apt-transport-https \
         ca-certificates \
         curl \
         gnupg2 \
         software-properties-common

    if dpkg -s docker-ce | grep Status: | grep installed ; then
      echo "Docker Installed"
    else
      echo "Installing Docker-CE"

      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
      add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
      apt-get update
      apt-get -y install docker-ce
    fi
}

function install_oracle (){
    echo "Oracle Linux 7.x/8.x/9.x Install"
    echo "Installing Base Oracle Linux Packages"

    NO_BEST=""
    if [[ "${1}" == '"8.'* ]] || [[ "${1}" == '"9.'* ]]; then
        NO_BEST="--nobest"
    else
        sudo yum-config-manager --enable ol7_developer
    fi

    yum install -y yum-utils \
        device-mapper-persistent-data \
        lvm2 \
        lsof

    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo

    echo "Installing Docker-CE"
    yum install -y docker-ce $NO_BEST
    systemctl start docker
}

function install_openssl (){
    if [ "${OS_ID}" == "ubuntu" ] && ( [ "${OS_VERSION_ID}" == '"18.04"' ] || [ "${OS_VERSION_ID}" == '"20.04"' ] || [ "${OS_VERSION_ID}" == '"22.04"' ] ) ; then
        sudo apt-get update
        sudo apt-get install -y openssl
    fi
    if [ "${OS_ID}" == "debian" ] && ( [ "${OS_VERSION_ID}" == '"9"' ] || [ "${OS_VERSION_ID}" == '"10"' ] || [ "${OS_VERSION_ID}" == '"11"' ] ) ; then
        sudo apt-get update
        sudo apt-get install -y openssl
    fi
    if [ "${OS_ID}" == '"centos"' ] && ( [ "${OS_VERSION_ID}" == '"7"' ] || [ "${OS_VERSION_ID}" == '"8"' ] || [ "${OS_VERSION_ID}" == '"9"' ] ) ; then
        yum install -y openssl
    fi
    if [ "${OS_ID}" == '"ol"' ] && ( [[ "${OS_VERSION_ID}" == '"7.'* ]] || [[ "${OS_VERSION_ID}" == '"8.'* ]] || [[ "${OS_VERSION_ID}" == '"9.'* ]] ) ; then
        yum install -y openssl
    fi
}

if [ -f /etc/os-release ] ; then
    OS_ID="$(awk -F= '/^ID=/{print $2}' /etc/os-release)"
    OS_VERSION_ID="$(awk -F= '/^VERSION_ID/{print $2}' /etc/os-release)"
fi

if ! openssl version > /dev/null 2>&1; then
    echo "Installing OpenSSL"
    install_openssl
fi

check_docker_dependencies

if [ "${OS_ID}" == "ubuntu" ] && ( [ "${OS_VERSION_ID}" == '"18.04"' ] || [ "${OS_VERSION_ID}" == '"20.04"' ] || [ "${OS_VERSION_ID}" == '"22.04"' ] ) ; then
    SUPPORTED='true'
    if [ $INSTALL_DOCKER == 'true' ] ; then
        install_ubuntu
    fi

    if [ $INSTALL_COMPOSE == 'true' ] ; then
        install_docker_compose
    fi
fi

if [ "${OS_ID}" == "debian" ] && ( [ "${OS_VERSION_ID}" == '"9"' ] || [ "${OS_VERSION_ID}" == '"10"' ] || [ "${OS_VERSION_ID}" == '"11"' ] ) ; then
    SUPPORTED='true'
    if [ $INSTALL_DOCKER == 'true' ] ; then
        install_debian
    fi

    if [ $INSTALL_COMPOSE == 'true' ] ; then
        install_docker_compose
    fi
fi

if [ "${OS_ID}" == '"centos"' ] && ( [ "${OS_VERSION_ID}" == '"7"' ] || [ "${OS_VERSION_ID}" == '"8"' ] || [ "${OS_VERSION_ID}" == '"9"' ] ) ; then
    SUPPORTED='true'
    if [ $INSTALL_DOCKER == 'true' ] ; then
        install_centos ${OS_VERSION_ID}
    fi

    if [ $INSTALL_COMPOSE == 'true' ] ; then
        install_docker_compose
    fi
fi

if [ "${OS_ID}" == '"ol"' ] && ( [[ "${OS_VERSION_ID}" == '"7.'* ]] || [[ "${OS_VERSION_ID}" == '"8.'* ]] || [[ "${OS_VERSION_ID}" == '"9.'* ]] ) ; then
    SUPPORTED='true'
    if [ $INSTALL_DOCKER == 'true' ] ; then
        install_oracle ${OS_VERSION_ID}
    fi

    if [ $INSTALL_COMPOSE == 'true' ] ; then
        install_docker_compose
    fi
fi

if [ "${SUPPORTED}" == "false" ] ; then
   echo "Installation Not Supported for this Operating System. Exiting"
   exit -1
fi

echo "Dependency Installation Complete"
