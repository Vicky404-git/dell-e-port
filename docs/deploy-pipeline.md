# 🔁 Push-to-Deploy Pipeline

This project uses a **bare Git repo + post-receive hook** for automated deployment.
No Jenkins. No GitHub Actions. No external dependencies.
Just Git, Bash, and Docker — light enough for a dual-core CPU from 2014.

---

## How It Works
Your Laptop                        Dell Server

git push production master   →     bare repo receives push
↓
post-receive hook fires
↓
checks out latest code
↓
docker compose up -d

One command on your end. Automatic on the server's end.

---

## Server-Side Setup (do this once)

### 1. Initialize the bare repo

```bash
git init --bare /srv/dell-e-port.git
```

A bare repo has no working tree — it just stores Git objects.
It's the "remote" that lives on the server.

### 2. Install the post-receive hook

```bash
cp scripts/post-receive /srv/dell-e-port.git/hooks/post-receive
chmod +x /srv/dell-e-port.git/hooks/post-receive
```

This hook runs automatically every time a push lands on the server.

### 3. Make sure the live directory exists

```bash
mkdir -p /srv/dell-e-port
```

This is where the hook checks out your code before restarting Docker.

---

## Client-Side Setup (your main laptop, do this once)

### 1. Add the server as a Git remote

```bash
git remote add production ssh://YOUR_USER@100.x.x.x/srv/dell-e-port.git
```

Replace `YOUR_USER` with your Linux username on the Dell.
Replace `100.x.x.x` with your Tailscale IP (run `tailscale ip` on the server).

### 2. Deploy

```bash
git push production master
```

That's it. Watch the terminal — the hook output streams back to you live.

---

## What the Hook Actually Does

```bash
# 1. Checks out latest code into the live directory
git --work-tree=/srv/dell-e-port --git-dir=/srv/dell-e-port.git checkout master -f

# 2. Restarts containers
cd /srv/dell-e-port
docker compose down
docker compose up -d
```

Full script: `scripts/post-receive`

---

## Why Not Jenkins / GitHub Actions?

- Jenkins needs ~256MB RAM just to idle. This machine has 4GB shared with Immich + Jellyfin.
- GitHub Actions needs an internet round-trip for every deploy.
- This hook runs **locally on the server**, completes in ~10 seconds, zero overhead.

For a single-node homelab, this is the right tool for the job.

---

## Troubleshooting

**Push rejected?**
```bash
# Make sure the hook is executable
chmod +x /srv/dell-e-port.git/hooks/post-receive
```

**SSH connection refused?**
```bash
# Make sure Tailscale is running on the server
sudo tailscale up
tailscale ip  # grab your 100.x.x.x IP
```

**Containers didn't restart?**
```bash
# Check Docker logs directly on the server
docker logs -f immich_server
```

**Wrong user running Docker?**
```bash
# Add your user to the docker group (then log out and back in)
sudo usermod -aG docker $USER
```
