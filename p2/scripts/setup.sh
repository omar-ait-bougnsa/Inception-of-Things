#!/bin/bash

# Install K3s
curl -sfL https://get.k3s.io | sh -


until kubectl get nodes >/dev/null 2>&1
do
    sleep 2
done

# Apply Kubernetes configuration
kubectl apply -f /vagrant/confs/deployment.yml
kubectl apply -f /vagrant/confs/service.yml