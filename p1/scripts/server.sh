#!/bin/bash
set -e

curl -sfL https://get.k3s.io | sh -

echo "Waiting for K3s..."

until sudo k3s kubectl get nodes >/dev/null 2>&1; do
    sleep 2
done

sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/k3s-token

echo "K3s Server is ready."