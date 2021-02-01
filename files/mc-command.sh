#!/bin/bash
CONTAINER_NAME=$1

docker exec -i ${CONTAINER_NAME} rcon-cli

