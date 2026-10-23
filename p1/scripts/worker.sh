#!/bin/bash
set -e

apt-get update
apt-get install curl -y

echo "Waiting for K3s server..."

until curl -sk https://192.168.56.110:6443/ping >/dev/null; do
    sleep 2
done

curl -sfL https://get.k3s.io | \
  K3S_URL=https://192.168.56.110:6443 \
  K3S_TOKEN=oait-bou-k3s-token \
  INSTALL_K3S_EXEC="agent --node-ip=192.168.56.111 --flannel-iface=eth1" \
  sh -

echo "K3s Agent joined the cluster."
