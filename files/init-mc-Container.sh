#!/bin/bash
HOST_PORT=$(docker ps --format '{{.Ports}}' | awk -F'[:-]' '{print $2}' | sort -r | head -1 | awk '{nextport = $1+1} {print nextport}')
CONTAINER_NAME=$1

mkdir -p /home/minecraft_ops/minecraft_data/${CONTAINER_NAME}/

docker run -d -v /home/minecraft_ops/minecraft_data/${CONTAINER_NAME}:/data \
        -p ${HOST_PORT}:25565 \
        -e EULA=TRUE \
        -e TYPE=PAPER \
        -e VERSION=1.15.2 \
        -e MEMORY=2G \
        -e TZ=Asia/Tokyo \
        -e GUI=FALSE \
        --name ${CONTAINER_NAME} \
        itzg/minecraft-server

sleep 10

ls $CONTAINER_NAME/* | while read line; do docker cp $line $CONTAINER_NAME:/data/plugins/ ; done

docker restart ${CONTAINER_NAME}

IPADDRESS=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)

echo "$IPADDRESS:$HOST_PORT"