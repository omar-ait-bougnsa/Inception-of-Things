kubectl create namespace gitlab
kubectl apply -f bonus/gitlab/deployment.yaml -n gitlab
kubectl apply -f bonus/gitlab/service.yaml -n gitlab
echo "waiting for gitlab untill is available"
kubectl wait -n gitlab --for=condition=available deploy/gitlab --timeout=-1s
until curl --fail 0.0.0.0:30081 2> /dev/null ; do printf "\rwaiting for the gitlab webapp..." ; sleep 5; done
# init the development project for bonus
# this applyed after push the repo
# kubectl apply -f bonus/manifests/application.yaml