#!/bin/bash

# Execute packaging analysis for the database image.
snyk container test --severity-threshold=high docker-archive:/tmp/demo-database.tar --file=./database/Dockerfile

status=`echo $?`

# Check if there is any vulnerability.
if [ $status -eq 0 ]; then
  # Execute packaging analysis for the backend image.
	snyk container test --severity-threshold=high docker-archive:/tmp/demo-backend.tar --file=./backend/Dockerfile

	status=`echo $?`

  # Check if there is any vulnerability.
	if [ $status -eq 0 ]; then
    # Execute packaging analysis for the frontend image.
		snyk container test --severity-threshold=high docker-archive:/tmp/demo-frontend.tar --file=./frontend/Dockerfile

		status=`echo $?`
	fi
fi

# Return if there is any vulnerability.
exit $status