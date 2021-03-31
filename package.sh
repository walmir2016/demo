#!/bin/bash

docker login -u fvilarinho -p $GITHUB_TOKEN docker.pkg.github.com
docker build -t ghcr.io/fvilarinho/demo:latest .