#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

# https://kind.sigs.k8s.io/docs/user/quick-start/
echo "=============================deploy kind============================================================="

docker version
export KIND_VERSION="0.11.1"

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v$KIND_VERSION/kind-$(uname)-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind

# create two clusters
kind create cluster # Default cluster context name is `kind`.
# If the flag --name is not specified, kind will use the default cluster context name kind
kind create cluster --name kind-2

kind get clusters #see the list of kind clusters

#kind is prefixed to the context and cluster names, for example: kind-istio-testing
kubectl config get-contexts 

kubectl cluster-info --context kind-kind
kubectl cluster-info --context kind-kind-2

# extract the detailed information about a cluster
kubectl cluster-info dump --context kind-kind
kubectl cluster-info dump --context kind-kind-2



# Deleting a Cluster
# If the flag --name is not specified, kind will use the default cluster context name kind
kind delete cluster --name kind-2
kind get clusters #see the list of kind clusters

docker ps 
kubectl get nodes

kubectl get namespaces
kubectl --namespace kube-system get pods

echo "=============================deploy kind============================================================="