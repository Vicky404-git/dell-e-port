#!/bin/bash

echo "📦 Installing dependencies..."
sudo apt update
sudo apt install -y docker.io docker-compose samba

echo "📁 Creating storage..."
sudo mkdir -p /srv/dell-e-port/photos
sudo chown -R $USER:$USER /srv/dell-e-port

echo "🐳 Starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "💾 Creating swap (4GB)..."
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

echo "🚀 Setup complete!"
