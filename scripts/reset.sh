#!/bin/bash
echo "⚠️ This will remove containers (NOT your data)"
docker compose down --remove-orphans
docker system prune -f
