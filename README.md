# 🖥️ Dell E-Port — Turn Old Laptop into NAS + Immich Server

## 🚀 Features

* 📂 NAS (Samba file sharing)
* 📸 Self-hosted Google Photos alternative (Immich)
* 🌐 Remote access (Tailscale)
* 🐳 Docker-based setup

---

## 🧰 Requirements

* Old laptop / PC
* Debian / Linux
* Docker + Docker Compose

---

## ⚡ Quick Start

### 1. Clone repo

```bash
git clone https://github.com/yourusername/dell-e-port.git
cd dell-e-port
```

---

### 2. Setup environment

```bash
cp .env.example .env
nano .env
```

---

### 3. Create storage

```bash
sudo mkdir -p /srv/dell-e-port/photos
sudo chown -R $USER:$USER /srv/dell-e-port
```

---

### 4. Run

```bash
docker compose up -d
```

---

### 5. Open Immich

```
http://localhost:2283
```

---

## 📂 Samba Setup (NAS)

Install Samba:

```bash
sudo apt install samba
```

Edit config:

```bash
sudo nano /etc/samba/smb.conf
```

Add:

```ini
[Photos]
   path = /srv/dell-e-port/photos
   browseable = yes
   writable = yes
   guest ok = no
```

Restart:

```bash
sudo systemctl restart smbd
```

---

## 🌐 Remote Access (Tailscale)

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

---
## ⚡ One-line setup
```
```
```bash
git clone ...
cd dell-e-port
chmod +x scripts/setup.sh
./scripts/setup.sh

```

## ⚠️ Notes

* Do NOT upload `.env`
* Do NOT modify Immich folders manually
* Disable ML on low-end systems

---

## 🧠 Future Plans

* Web dashboard
* Backup system
* Monitoring

---

