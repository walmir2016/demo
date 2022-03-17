#!/bin/bash

# Define packaging analysis environment.
export BUILD_VERSION=`sed 's/BUILD_VERSION=//g' ./iac/.env`

# Generate the local binary file for the database image.
docker save felipevilarinho/demo-database:$BUILD_VERSION -o demo-database.tar

# Execute packaging analysis for the database image.
snyk container test --severity-threshold=high docker-archive:demo-database.tar --file=./database/Dockerfile

status=`echo $?`

# Clean temporary file.
rm -f demo-database.tar

# Check if there is any vulnerability.
if [ $status -eq 0 ]; then
  # Generate the local binary file for the backend image.
	docker save felipevilarinho/demo-backend:$BUILD_VERSION -o demo-backend.tar

  # Execute packaging analysis for the backend image.
	snyk container test --severity-threshold=high docker-archive:demo-backend.tar --file=./backend/Dockerfile

	status=`echo $?`

  # Clean temporary file.
	rm -f demo-backend.tar

  # Check if there is any vulnerability.
	if [ $status -eq 0 ]; then
    # Generate the local binary file for the frontend image.
		docker save felipevilarinho/demo-frontend:$BUILD_VERSION -o demo-frontend.tar

    # Execute packaging analysis for the frontend image.
		snyk container test --severity-threshold=high docker-archive:demo-frontend.tar --file=./frontend/Dockerfile

		status=`echo $?`

    # Clean temporary file.
		rm -f demo-frontend.tar
	fi
fi

# Return if there is any vulnerability.
exit $status