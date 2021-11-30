#!/bin/bash

export DD_AGENT_MAJOR_VERSION=7
export DD_API_KEY=${DATADOG_AGENT_TOKEN}
export DD_SITE="datadoghq.com"

bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"