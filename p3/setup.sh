#!/usr/bin/env bash

#default password if .env not exists
ARGOCD_PASSWORD=Password@@22

# installing k3d if not exist
k3d --version || curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

#create cluster node
k3d cluster create mycluster\
	--port 8888:30000@loadbalancer\
	--port 8889:30001@loadbalancer\
	--port 8080:30443@loadbalancer\
	--port 30081:30081@loadbalancer
													

# download and install kubectl in not exist
if [ ! -f ~/.local/bin/kubectl ]; then
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x kubectl
	mkdir -p ~/.local/bin
	mv ./kubectl ~/.local/bin/kubectl
fi

# download and install argocd-cli in not exist
if [ ! -f ~/.local/bin/argocd ]; then
curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
	chmod +x argocd
mkdir -p ~/.local/bin
	mv ./argocd ~/.local/bin/argocd
fi

# init argocd 
kubectl create namespace argocd
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# set nodePort for argocd public access
kubectl -n argocd patch svc argocd-server -p \
  '{"spec":{"type":"NodePort","ports":[{"name":"https","port":443,"targetPort":8080,"nodePort":30443}]}}'

# waiting until argocd is available
echo "waiting argocd until is available..."
kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=300s
sleep 5
# argocd cli login
ARGOCD_DEFAULT_PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d)

argocd login 127.0.0.1:8080 --insecure --username admin --password "$ARGOCD_DEFAULT_PASS"

#change argocd password
argocd account update-password   --current-password $ARGOCD_DEFAULT_PASS --new-password $ARGOCD_PASSWORD

# init the development project
kubectl apply -f p3/manifests/app-project.yaml
kubectl apply -f p3/manifests/application.yaml