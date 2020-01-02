#!/bin/bash

mkdir -p ~/programas

cd ~/programas

sudo pip3 install undervolt

# iniciar automaticamente systemd
# crear archivo en /etc/systemd/system/undervolt.service
#[Unit]
#Description=undervolt
#
#[Service]
#Type=oneshot
#ExecStart=/usr/local/bin/undervolt -v --core -135 --cache -135 --gpu -135

# crear timer en /etc/systemd/system/undervolt.timer
#[Unit]
#Description=Apply undervolt settings
#
#[Timer]
#Unit=undervolt.service
## Wait 2 minutes after boot before first applying
#OnBootSec=2min
## Run every 30 seconds
#OnUnitActiveSec=30
#
#[Install]
#WantedBy=multi-user.target

# activar servicio
# sudo systemctl enable undervolt.timer
# sudo systemctl start undervolt.timer
