#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="iot"
ARGO_NAMESPACE="argocd"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create the K3d cluster, or reuse it when the script is run again.
if k3d cluster list | grep -qE "^${CLUSTER_NAME}[[:space:]]"; then
  echo "K3d cluster ${CLUSTER_NAME} already exists; using it."
else
  k3d cluster create "$CLUSTER_NAME" \
    --runtime-ulimit "nofile=65536:65536" \
    --wait
fi

# Point kubectl to the new K3d cluster
kubectl config use-context "k3d-${CLUSTER_NAME}"

# Create the namespace and install Argo CD inside K3d
kubectl create namespace "$ARGO_NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -n "$ARGO_NAMESPACE" --server-side --force-conflicts \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait until Argo CD is ready
kubectl rollout status deployment/argocd-server \
  -n "$ARGO_NAMESPACE" --timeout=180s

# Create the Argo CD Application resource inside K3d
kubectl apply -f "$SCRIPT_DIR/../confs/argocd-application.yaml"

# Show the result
kubectl get applications -n "$ARGO_NAMESPACE"
kubectl get pods -n dev