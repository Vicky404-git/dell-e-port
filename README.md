# 🖥️ Dell E-Port — Turn Old Laptop into NAS + Immich Server

## 🧱 Architecture
┌──────────────────────────────┐
│        LAPTOP (SERVER)       │
│   Debian 13 · Docker · i3wm  │
│                              │
│ ┌───────┐ ┌────────┐ ┌─────┐ │
│ │ Immich│ │Jellyfin│ │Samba│ │
│ │ :2283 │ │ :8096  │ │ NAS │ │
│ └───────┘ └────────┘ └─────┘ │
│     │         │              │
│ ┌────────┐ ┌─────┐           │
│ │Postgres│ │Redis│           │
│ └────────┘ └─────┘           │
└───────────────┬──────────────┘
                │
          Tailscale Mesh
         ┌──────┴──────┐
         │ Your Laptop │
         │  anywhere   │
         └─────────────┘
---

## 🚀 What's Running

| Service | Purpose | Port |
|---|---|---|
| **Immich** | Self-hosted Google Photos alternative | 2283 |
| **Jellyfin** | Media server with Intel QuickSync transcoding | 8096 |
| **Samba** | Local NAS — raw file storage | — |
| **Tailscale** | Secure remote access from anywhere | — |

---

## ⚡ Quick Start

### Prerequisites
- A laptop/PC running Debian 12/13
- At least 4GB RAM (8GB recommended)
- Docker will be installed by the setup script

### 1. Clone the repo

```bash
git clone https://github.com/Vicky404-git/dell-e-port.git
cd dell-e-port
```

### 2. Configure environment

```bash
cp .env.example .env
nano .env   # fill in your actual paths and passwords
```

### 3. Run setup (once)

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

> ⚠️ After setup, **log out and back in** before continuing.
> Docker group permissions don't apply until you do.

### 4. Start everything

```bash
docker compose up -d
```

### 5. Access your services
```
Immich  → http://localhost:2283
Jellyfin → http://localhost:8096
```

---

## ⚠️ Hardware-Specific Things (Read Before Starting)

### Intel QuickSync (Jellyfin transcoding)
The `docker-compose.yml` passes through `/dev/dri/renderD128` for hardware transcoding.
This path is **specific to my machine**.

Check yours first:
```bash
ls /dev/dri/
```

If you don't have Intel QuickSync, remove the `devices:` block from the Jellyfin service in `docker-compose.yml`.

### AMD GPU (Immich ML — currently disabled)
The `immich-machine-learning` service is commented out.
The AMD GPU kept crashing the container, so facial recognition runs on CPU for now.
If you have a stable GPU, uncomment that block and update the device path.

---

## 📂 Docs

| Doc | What it covers |
|---|---|
| [Deploy Pipeline](docs/deploy-pipeline.md) | How `git push` auto-deploys to the server |
| [Samba Setup](docs/samba.md) | NAS / file sharing setup |
| [Tailscale Setup](docs/tailscale.md) | Remote access from anywhere |
| [Troubleshooting](docs/troubleshooting.md) | Common errors and fixes |

---

## 🛠️ Useful Scripts

| Script | What it does |
|---|---|
| `scripts/setup.sh` | First-time server setup |
| `scripts/deploy.sh` | Manual redeploy (if not using the pipeline) |
| `scripts/fix-permissions.sh` | Fix storage permission errors |
| `scripts/reset.sh` | Nuke containers (data is safe) |

---

## 🧠 Future Plans

- [ ] Web dashboard (status + quick controls)
- [ ] Automated backup to external drive
- [ ] Uptime monitoring
- [ ] Re-enable ML once GPU is stable

---

## 💬 Context

Built this because I wanted to own the infrastructure my code runs on, not just rent it.
The most interesting part is the [push-to-deploy pipeline](docs/deploy-pipeline.md) —
`git push production master` from my main laptop redeploys everything on the server automatically.
