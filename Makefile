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
