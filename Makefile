p3:
	@bash p3/setup.sh

p3_fclean:
	@k3d cluster delete mycluster

bonus:
	@bash bonus/setup.sh

bonus_extra:
	@kubectl apply -f bonus/manifests/application.yaml

.PHONY: p1 p3 bonus