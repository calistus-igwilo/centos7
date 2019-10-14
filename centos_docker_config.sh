#!/bin/bash

# This script configures Centos and installs Docker on the OS.

# To run the script from Centos command prompt, the file should be made executable:
# chmod +x contos_docker_config.sh
# sh centos_docker_config.sh

#for questions, checkout the github repository: www.github.com/calistus-igwilo
# Or send enquiries to calistus@caltech-ltd.com


# **** Start *******

# Update server
sudo yum update -y

# Set timezone to Lagos
sudo timedatectl set-timezone Africa/Lagos

# Disable Network Manager
sudo systemctl disable NetworkManager

# Append NM_CONTROLLED="no" to the network interface
echo "NM_CONTROLLED="no"" | sudo tee -a /etc/sysconfig/network-scripts/ifcfg-eth0

# Install required packages for Docker
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# Setup docker stable repository
 sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install the latest Docker-Engine Community
sudo yum install docker-ce docker-ce-cli containerd.io -y

# Start Docker
sudo systemctl start docker

# Enable Docker at startup
sudo systemctl enable docker

# Add user to docker and sudo groups
sudo usermod -aG docker $USER
sudo usermod -aG wheel $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# Install Bash Command Completion
sudo yum -y install bash-completion

sudo curl -L https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

# Install git
sudo yum install git -y

# Install wget
sudo yum install wget -y

# Done


