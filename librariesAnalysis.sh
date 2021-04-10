#!/bin/bash

SNYK_CMD=`which snyk`

if [ -z "$SNYK_CMD" ]; then
  SNYK_CMD=./snyk
fi

$SNYK_CMD monitor