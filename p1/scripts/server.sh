#!/bin/bash
set -e

apt-get update
apt-get install curl -y

curl -sfL https://get.k3s.io | \
  K3S_TOKEN=oait-bou-k3s-token \
  INSTALL_K3S_EXEC="server --node-ip=192.168.56.110 --flannel-iface=eth1 --write-kubeconfig-mode=644" \
  sh -

echo "K3s Server is ready."
