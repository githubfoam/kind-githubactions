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

kubectl cluster-info --context kind-kind
kubectl cluster-info --context kind-kind-2

kubectl config get-contexts #kind is prefixed to the context and cluster names, for example: kind-istio-testing

# Deleting a Cluster
# If the flag --name is not specified, kind will use the default cluster context name kind
kind delete cluster --name kind-2
kind get clusters #see the list of kind clusters

echo "=============================deploy kind============================================================="