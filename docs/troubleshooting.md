# 🛠️ Troubleshooting

## Immich not opening

* Wait 1–2 minutes (first startup)
* Check logs:
  docker logs -f immich_server

## Port not accessible

* Check firewall:
  sudo ufw allow 2283

## Samba not visible

* Restart service:
  sudo systemctl restart smbd

## Docker issues

* Clean restart:
  docker compose down --remove-orphans
  docker compose up -d

