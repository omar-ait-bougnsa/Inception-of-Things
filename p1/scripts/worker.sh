#!/bin/bash
set -e

SERVER_IP="192.168.56.110"

echo "Waiting for K3s token..."

while [ ! -f /vagrant/k3s-token ]; do
    sleep 2
done

K3S_TOKEN=$(cat /vagrant/k3s-token)

curl -sfL https://get.k3s.io | \
    K3S_URL="https://${SERVER_IP}:6443" \
    K3S_TOKEN="$K3S_TOKEN" \
    sh -

echo "K3s Agent joined the cluster."