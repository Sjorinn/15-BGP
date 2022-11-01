#!/usr/bin/env bash

CONTAINER_NAME=$1
HOSTNAME=$(docker exec -it $CONTAINER_NAME hostname)
echo "Let's change $CONTAINER_NAME to $HOSTNAME"
docker rename $CONTAINER_NAME $HOSTNAME
