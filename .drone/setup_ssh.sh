#!/usr/bin/env sh

set -e

# Setup ssh inside container
mkdir -p ~/.ssh
echo "$GITEA_SSH_KEY" > ~/.ssh/id_rsa
echo "[git.b12f.io]:2222 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4uaREL7acSSCNAX+voDYl1Kj7JipP62fR5x1UyGP9u" >> ~/.ssh/known_hosts
echo "Host git.b12f.io" >> ~/.ssh/config
echo "  Port 2222" >> ~/.ssh/config
chmod -R 600 ~/.ssh
