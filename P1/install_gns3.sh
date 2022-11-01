#!/usr/bin/env bash

# https://docs.gns3.com/docs/getting-started/installation/linux/

sudo add-apt-repository ppa:gns3/ppa
sudo apt update -y                                
sudo apt install -y gns3-gui gns3-server

# For IOU support
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install gns3-iou

# Install Docker CE
sudo apt -y remove docker docker-engine docker.io
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce

docker pull alpine
docker pull frrouting/frr
docker pull peerdebakker/badass-gns3

# TODO: make this a loop
sudo usermod -aG ubridge $USER
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
sudo usermod -aG wireshark $USER
sudo usermod -aG docker $USER
