#!/bin/bash
set -e

apt-get update
apt-get install curl -y

SERVER_IP="192.168.56.110"

echo "Waiting for K3s token..."

while [ ! -f /vagrant/k3s-token ]; do
    sleep 2
done

K3S_TOKEN=$(cat /vagrant/k3s-token)

export K3S_URL="https://${SERVER_IP}:6443"
export K3S_TOKEN

curl -sfL https://get.k3s.io | \
  K3S_URL=$K3S_URL \
  K3S_TOKEN=$K3S_TOKEN \
  INSTALL_K3S_EXEC="agent --node-ip=192.168.56.111 --flannel-iface=eth1" \
  sh -

echo "K3s Agent joined the cluster."