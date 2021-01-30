#!/bin/bash
HOST_PORT=$(docker ps --format '{{.Ports}}' | awk -F'[:-]' '{print $2}' | sort -r | head -1 | awk '{nextport = $1+1} {print nextport}')
CONTAINER_NAME=$1
IPADDRESS=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)

docker ps -a -f name="^${CONTAINER_NAME}$" --format '{{.Names}}' | grep ${CONTAINER_NAME}  > /dev/null
if [ "$?" = "0" ]; then
    docker restart ${CONTAINER_NAME}
    exit 0
    echo "$IPADDRESS:$HOST_PORT"
fi

mkdir -p ./minecraft_data/${CONTAINER_NAME}/

cp -r config/ops.json ./minecraft_data/${CONTAINER_NAME}/

docker run -d \
        -v $PWD/minecraft_data/${CONTAINER_NAME}:/data \
        -v $PWD/packs/${CONTAINER_NAME}:/data/plugins/ \
        -p ${HOST_PORT}:25565 \
        -e EULA=TRUE \
        -e TYPE=PAPER \
        -e VERSION=1.15.2 \
        -e MEMORY=2G \
        -e TZ=Asia/Tokyo \
        -e GUI=FALSE \
        --name ${CONTAINER_NAME} \
        itzg/minecraft-server

echo "$IPADDRESS:$HOST_PORT"