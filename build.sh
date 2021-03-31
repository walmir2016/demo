#!/bin/bash

# Compile and Code Analysis (Sonarcloud and Snyk).
# Sonarcloud analyze the source code and Snyk analyze the libraries and dependencies.
# When it runs in github actions, all environments variables must have a secret with the same name.
#
# **** WARNING *****
# DON'T EXPOSE OR COMMIT ANY VARIABLE IN THE PROJECT.
#
# If you will run locally, set the environment variables in the .bash_profile.
# Environment variables used:
# - GITHUB_TOKEN: Token to connect with authenticate in github by Sonarcloud/Snyk (Used to get the source files and analyze it).
# - SONAR_TOKEN: Token to connect with Sonarcloud and store the analysis.
# - SNYK_TOKEN: Token to connect with Snyk and store the analysis.

./gradlew clean build sonarqube snyk-monitor