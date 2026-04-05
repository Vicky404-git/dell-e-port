cat <<'EOF' >deploy.sh
#!/bin/bash
echo "🔄 Restarting Docker containers..."
docker compose down
docker compose up -d
echo "✅ Matrix is back online!"
EOF
