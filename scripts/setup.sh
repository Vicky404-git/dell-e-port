#!/bin/bash

echo "🚀 Setting up Dell E-Port (NAS + Immich)"

# Update system

echo "📦 Updating system..."
sudo apt update && sudo apt upgrade -y

# Install Docker

echo "🐳 Installing Docker..."
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group

sudo usermod -aG docker $USER

# Install Samba

echo "📂 Installing Samba..."
sudo apt install -y samba

# Create storage

echo "📁 Creating storage directories..."
sudo mkdir -p /srv/dell-e-port/photos
sudo chown -R $USER:$USER /srv/dell-e-port

# Copy env

if [ ! -f .env ]; then
  cp .env.example .env
  echo "⚠️ Edit .env before running docker!"
fi

echo "✅ Setup complete!"
echo "👉 Now run: docker compose up -d"
