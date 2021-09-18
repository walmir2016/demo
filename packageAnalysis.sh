#!/bin/bash

SNYK_CMD=`which snyk`

if [ -z "$SNYK_CMD" ]; then
  SNYK_CMD=./snyk
fi

$SNYK_CMD container monitor ghcr.io/fvilarinho/demo-database:latest
$SNYK_CMD container monitor ghcr.io/fvilarinho/demo-backend:latest
$SNYK_CMD container monitor ghcr.io/fvilarinho/demo-frontend:latest