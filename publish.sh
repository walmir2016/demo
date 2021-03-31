#!/bin/bash

docker login -u fvilarinho -p $GITHUB_TOKEN ghcr.io
docker push ghcr.io/fvilarinho/demo:latest