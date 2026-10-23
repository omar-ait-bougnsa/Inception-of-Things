#!/bin/bash
set -e

apt-get update
apt-get install curl -y

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=192.168.56.110 --flannel-iface=eth1 --write-kubeconfig-mode=644" sh -

echo "Waiting for K3s..."

until sudo k3s kubectl get nodes >/dev/null 2>&1; do
    sleep 2
done

sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/k3s-token

echo "K3s Server is ready."