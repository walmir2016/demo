#!/bin/bash

SNYK_CMD=`which snyk`

if [ -z "$SNYK_CMD" ]; then
  SNYK_CMD=./snyk
fi

docker save ghcr.io/fvilarinho/demo-database:latest -o demo-database.tar

$SNYK_CMD container test --severity-threshold=high docker-archive:demo-database.tar --file=./database/Dockerfile

status=`echo $?`

rm -f demo-database.tar

if [ $status -eq 0 ]; then
	docker save ghcr.io/fvilarinho/demo-backend:latest -o demo-backend.tar

	$SNYK_CMD container test --severity-threshold=high docker-archive:demo-backend.tar --file=./backend/Dockerfile

	status=`echo $?`

	rm -f demo-backend.tar

	if [ $status -eq 0 ]; then
		docker save ghcr.io/fvilarinho/demo-frontend:latest -o demo-frontend.tar

		$SNYK_CMD container test --severity-threshold=high docker-archive:demo-frontend.tar --file=./frontend/Dockerfile

		status=`echo $?`

		rm -f demo-frontend.tar
	fi
fi

exit $status
