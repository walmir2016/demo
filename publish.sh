#!/bin/bash

docker login -u fvilarinho -p $GITHUB_TOKEN docker.pkg.github.com
docker push ghcr.io/fvilarinho/demo:latest