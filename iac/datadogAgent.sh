#!/bin/bash

DD_AGENT_MAJOR_VERSION=7
DD_API_KEY=${DATADOG_AGENT_TOKEN}
DD_SITE="datadoghq.com"
bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"