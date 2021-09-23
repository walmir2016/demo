#!/bin/bash

KUBECTL_CMD=`which kubectl`

if [ -z "$KUBECTL_CMD" ]; then
  KUBECTL_CMD=./kubectl
fi

if [ ! -z "$KUBECONFIG_TOKEN" ]; then
  mkdir -p ~/.kube

  echo "$KUBECONFIG_TOKEN" > ~/.kubeconfig

  $KUBECONFIG_TOKEN=`base64 -d -i ~/.kubeconfig`

  echo "$KUBECONFIG_TOKEN" > ~/.kube/config

  rm ~/.kubeconfig
fi

$KUBECTL_CMD set image statefulset database database=ghcr.io/fvilarinho/demo-database -n demo
$KUBECTL_CMD set image daemonset backend backend=ghcr.io/fvilarinho/demo-backend -n demo
$KUBECTL_CMD set image daemonSet frontend frontend=ghcr.io/fvilarinho/demo-frontend -n demo