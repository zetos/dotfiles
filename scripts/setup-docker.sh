#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." 
    exit 1
fi

# Start Docker service
systemctl start docker

# Enable Docker service on boot
systemctl enable docker

# Create Docker group
groupadd docker

# Add user to docker group
# usermod -aG docker $USER

gpasswd -a $USER docker
newgrp docker

# Verify Docker installation
# docker --version

# Test Docker installation
echo 'try running: "docker run hello-world" or "docker ps" without a sudo.'
echo 'Log out and log back in so that your group membership is re-evaluated.'
