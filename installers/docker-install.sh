#!/bin/sh

set -e

echo "Cleaning up potential old packages..." &&
    sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1) &&
    echo "Running initial update..." &&
    sudo apt update &&
    echo "Running system upgrades..." &&
    sudo apt upgrade -y &&
    echo "Installing dependencies..." &&
    sudo apt install -y ca-certificates curl &&
    echo "Installing docker package keys" &&
    sudo install -m 0755 -d /etc/apt/keyrings &&
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc &&
    sudo chmod a+r /etc/apt/keyrings/docker.asc &&
    echo "Adding docker repository..." &&
    {
        cat <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
    } >/etc/apt/sources.list.d/docker.sources &&
    echo "Updating..." &&
    sudo apt update &&
    echo "Installing Docker..." &&
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &&
    echo "Verifying install" &&
    sudo docker run hello-world
