MAKEFILE_PATH := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
PROJECT_ROOT := $(abspath $(MAKEFILE_PATH)/../)
NAMESPACE = argo
LATEST_ARGO_WF = $(shell bash -c  "argo list -n $(NAMESPACE) --no-headers -o name | head -n1")



install_k3d:
	curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=v3.0.0 bash

create_cluster:
	# Mounts local data directory to /data-fixtures in all nodes (for testing)"
	k3d cluster create \
		--wait \
		--verbose \
		--port 5000:80@loadbalancer \
		--volume $(PROJECT_ROOT)/data:/data-fixtures@all \
		test-cluster

switch_context:
	kubectl config use-context k3d-test-cluster

create_namespace:
	kubectl create ns $(NAMESPACE)

setup_argo_controller:
	kubectl apply -n $(NAMESPACE) --wait -f https://raw.githubusercontent.com/argoproj/argo/master/manifests/install.yaml
	# Modify the containerRuntimeExecutor
	kubectl -n $(NAMESPACE) apply --wait -f workflow-controller-configmap.yaml
	kubectl create clusterrolebinding serviceaccounts-cluster-admin \
	  --clusterrole=cluster-admin \
	  --group=system:serviceaccounts
	# Create a custom service account
	kubectl apply -n $(NAMESPACE) --wait -f service-account.yaml

# travis migration kind

deploy-kind:
	bash scripts/deploy-kind.sh

# python virtual environments
create_python2_venv:
	bash scripts/deploy-python2-venv.sh

create_python2_venv_auto:
	bash scripts/deploy-python2-venv-auto.sh

create_python3_venv:
	bash scripts/deploy-python3-venv.sh

create_python3_venv_auto:
	bash scripts/deploy-python3-venv-auto.sh	
