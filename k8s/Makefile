CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

production-console:
	kubectl exec -it $(shell kubectl get pod -lapp.kubernetes.io/name=hb-app-console-pod -o=custom-columns=NAME:metadata.name | sed -n 2p) -- bin/rails c -s

k8s-ubuntu-setup:
	snap install helm --classic
	snap install kubectl --classic
	snap install doctl

k8s-macos-setup:
	brew install helm doctl kubectl

local-cluster-setup:
	doctl auth init
	doctl kubernetes cluster kubeconfig save hexlet-basics-cluster-3

helm-install:
	helm install hb-app ./hb-app-chart

helm-install-metrics:
	helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
	helm repo update
	helm upgrade --install metrics-server metrics-server/metrics-server
	helm repo add datadog https://helm.datadoghq.com
	helm repo update

# helm install --name app ./app-chart
helm-upgrade-app:
	helm upgrade hb-app $(CURRENT_DIR)/hb-app-chart
	git reset HEAD
	git add $(CURRENT_DIR)/hb-app-chart/values.yaml
	git commit -m ":rocket: deploy"
	git push --no-verify

get-pods:
	kubectl get pod -w -o wide

describe-app:
	kubectl describe pod app

start-bash:
	kubectl delete pods alpine || true
	kubectl run -i --tty alpine --image=alpine --restart=Never -- sh
