#!/bin/bash

echo "📦 Installing Docker (Engine + Compose plugin)..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg samba

# Official Docker install (v2, not the broken apt package)
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

echo "📁 Creating storage directories..."
sudo mkdir -p /srv/dell-e-port/photos
sudo mkdir -p /srv/dell-e-port.git
sudo chown -R $USER:$USER /srv/dell-e-port

echo "🗃️ Initializing bare Git repo..."
git init --bare /srv/dell-e-port.git
echo "  → Now set up the post-receive hook manually (see docs/gitops.md)"

echo "💾 Creating swap (4GB)..."
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab # persist across reboots

echo "🚀 Setup complete! Log out and back in for Docker group to take effect."
