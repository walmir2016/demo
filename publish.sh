#!/bin/bash

echo $GITHUB_TOKEN | docker login -u fvilarinho ghcr.io --password-stdin

docker-compose push