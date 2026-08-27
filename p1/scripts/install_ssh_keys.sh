#!/bin/bash
set -e

SSH_DIR="/home/vagrant/.ssh"

mkdir -p "$SSH_DIR"

cat /tmp/id_ed25519.pub >> "$SSH_DIR/authorized_keys"
rm /tmp/id_ed25519.pub

chown -R vagrant:vagrant "$SSH_DIR"
chmod 700 "$SSH_DIR"
chmod 600 "$SSH_DIR/authorized_keys"

echo "SSH key configured successfully."