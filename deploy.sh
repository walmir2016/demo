#!/bin/bash

KUBECTL_CMD=`which kubectl`

if [ -z "$KUBECTL_CMD" ]; then
  KUBECTL_CMD=./kubectl
fi

if [ ! -z "$KUBECONFIG_DATA" ]; then
  mkdir -p ~/.kube

  echo "$KUBECONFIG_DATA" > ~/.kubeconfig

  KUBECONFIG_DATA=`base64 -d -i ~/.kubeconfig`

  echo "$KUBECONFIG_DATA" > ~/.kube/config

  rm ~/.kubeconfig
fi

$KUBECTL_CMD set image statefulset database database=$DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-database -n demo
$KUBECTL_CMD set image deployment backend backend=$DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-backend -n demo
$KUBECTL_CMD set image deployment frontend frontend=$DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-frontend -n demo