#!/bin/bash

echo "📥 Pulling latest code..."
git pull origin main

echo "🔄 Restarting services..."
docker compose down
docker compose up -d

echo "✅ Done"
