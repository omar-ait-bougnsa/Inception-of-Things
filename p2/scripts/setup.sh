#!/bin/bash

apt-get update
apt-get install curl -y

# Install K3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=192.168.56.110 --flannel-iface=eth1 --write-kubeconfig-mode=644" sh -


until kubectl get nodes >/dev/null 2>&1
do
    sleep 2
done

kubectl create configmap app1-html --from-file=/vagrant/confs/app1/index.html
kubectl create configmap app2-html --from-file=/vagrant/confs/app2/index.html
kubectl create configmap app3-html --from-file=/vagrant/confs/app3/index.html


kubectl apply -f /vagrant/confs/app1/deployment.yml
kubectl apply -f /vagrant/confs/app1/service.yml
kubectl apply -f /vagrant/confs/app1/ingress.yml

kubectl apply -f /vagrant/confs/app2/deployment.yml
kubectl apply -f /vagrant/confs/app2/service.yml
kubectl apply -f /vagrant/confs/app2/ingress.yml

kubectl apply -f /vagrant/confs/app3/deployment.yml
kubectl apply -f /vagrant/confs/app3/service.yml
kubectl apply -f /vagrant/confs/app3/ingress.yml
