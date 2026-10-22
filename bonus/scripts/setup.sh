#!/bin/bash
set -e
cd "$(dirname "$0")/.."

kubectl create namespace gitlab --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f confs/gitlab.yaml

echo "Waiting for GitLab (5-10 min)..."
kubectl wait -n gitlab --for=condition=available deploy/gitlab --timeout=1200s

echo "GitLab ready -> user: root  password: Oel-Moue@2026!"
echo "Open it with: kubectl port-forward -n gitlab svc/gitlab 8181:80"