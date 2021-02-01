#!/bin/bash

docker exec $1 rcon-cli stop

while :
do
	much=$(docker ps --format '{{.Names}}' | grep $1 | wc -l)
	if [ $much -eq '0' ]
	then
		docker rm $1
		exit 0
	fi
done
