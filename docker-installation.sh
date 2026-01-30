#!/bin/bash
set -e

echo "Checking Docker installation..."

if command -v docker >/dev/null 2>&1; then
    echo "Docker already installed: $(docker --version)"
    exit 0
fi

echo "Docker not found. Installing..."

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect OS"
    exit 1
fi

if [[ "$OS" != "ubuntu" && "$OS" != "debian" ]]; then
    echo "Unsupported OS: $OS"
    exit 1
fi

echo "Installing Docker on $OS..."

sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$OS/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/$OS $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker $USER
sudo newgrp docker

# Validate installation
if docker version >/dev/null 2>&1; then
    echo "Docker installed successfully: $(docker --version)"
else
    echo "Docker installation failed"
    exit 1
fi
