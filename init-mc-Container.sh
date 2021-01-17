
#!/bin/bash

CONTAINER_NAME=$(date +'%Y%m%d_%H%M%S')
USE_BASE_CONTAINER_NAME=$1
USE_PLUGIN_DIR=$2

docker images | grep $USE_BASE_CONTAINER_NAME > /dev/null

if [ $? -eq "1" ] ; then
	docker commit $USE_BASE_CONTAINER_NAME $USE_BASE_CONTAINER_NAME
fi

HOST_PORT=$(docker ps --format '{{.Ports}}' | awk -F'[:-]' '{print $2}' | sort -r | head -1 | awk '{nextport = $1+1} {print nextport}')

docker run --detach --name $CONTAINER_NAME --privileged --publish=$HOST_PORT:25565 $USE_BASE_CONTAINER_NAME /sbin/init   

ls $USE_PLUGIN_DIR/* | while read line; do docker cp $line $CONTAINER_NAME:/opt/minecraft/plugins/ ; done

docker exec -it $CONTAINER_NAME systemctl restart minecraft_server

IPADDRESS=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)

echo "$IPADDRESS:$HOST_PORT"
