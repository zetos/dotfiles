#!/bin/bash

echo 'Remember to run this script as sudo'

# Start Docker service
systemctl start docker

# Enable Docker service on boot
systemctl enable docker

# Create Docker group
groupadd docker

# Add user to docker group
usermod -aG docker $USER

# Verify Docker installation
# docker --version

# Test Docker installation
echo 'try running: "docker run hello-world" or "docker ps" without a sudo.'
echo 'Log out and log back in so that your group membership is re-evaluated.'
