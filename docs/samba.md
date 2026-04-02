# 📂 Samba Setup (NAS)

## Install

sudo apt install samba

## Configure

sudo nano /etc/samba/smb.conf

Add:

[Photos]
path = /srv/dell-e-port/photos
browseable = yes
writable = yes
guest ok = no

## Add user

sudo smbpasswd -a $USER

## Restart

sudo systemctl restart smbd

## Access

Windows:
\192.168.x.x\Photos

Android:
smb://192.168.x.x

