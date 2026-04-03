#!/bin/bash

sudo chown -R $USER:$USER /srv/dell-e-port
sudo chmod -R 775 /srv/dell-e-port

echo "✅ Permissions fixed"
