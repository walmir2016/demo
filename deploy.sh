#!/bin/bash

KUBECTL_CMD=`which kubectl`

if [ -z "$KUBECTL_CMD" ]; then
  KUBECTL_CMD=./kubectl
fi

if [ ! -z "$KUBECONFIG_TOKEN" ]; then
  mkdir -p ~/.kube

  echo "$KUBECONFIG_TOKEN" > ~/.kubeconfig

  KUBECONFIG_TOKEN=`base64 -d -i ~/.kubeconfig`

  echo "$KUBECONFIG_TOKEN" > ~/.kube/config

  rm ~/.kubeconfig
fi

BUILD_VERSION=`sed 's/BUILD_VERSION=//g' .env`

rm .env

$KUBECTL_CMD set image statefulset database database=ghcr.io/fvilarinho/demo-database:$BUILD_VERSION -n demo
$KUBECTL_CMD set image daemonset backend backend=ghcr.io/fvilarinho/demo-backend:$BUILD_VERSION -n demo
$KUBECTL_CMD set image daemonSet frontend frontend=ghcr.io/fvilarinho/demo-frontend:$BUILD_VERSION -n demo