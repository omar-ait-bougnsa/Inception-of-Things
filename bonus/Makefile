
NAMESPACE = gitlab
PORT      = 8181

gitlab:
	bash scripts/setup.sh

argocd:
	kubectl apply -f confs/argocd-app.yaml

# Expose GitLab on http://localhost:$(PORT)
forward:
	kubectl port-forward -n $(NAMESPACE) svc/gitlab $(PORT):80

clean:
	kubectl delete namespace $(NAMESPACE) --ignore-not-found

.PHONY: gitlab argocd forward clean
