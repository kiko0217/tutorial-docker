#!/bin/bash

usage() {
    echo usage: $0 port_mongo_express volume_name network_name driver_type
    exit 1
}

containsElement() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

createVolume() {
    echo create volume $1
    docker volume create $1
}
createNetwork() {
    echo create network $1 with driver $2
    docker network create --driver $2 $1
}

[[ $# -ne 4 ]] && usage || echo checking volume $2
array=($(docker volume ls -q))
containsElement  $2 "${array[@]}"
[[ $? -ne 0 ]] && createVolume $2 || echo volume $2 exist, checking network $3
array2=($(docker network ls --format '{{.Name}}'))
containsElement $3 "${array2[@]}"
[[ $? -ne 0 ]] && createNetwork $3 $4 || echo network $3 exist
docker container create \
--name mongodbserver \
--network $3 \
--mount "type=volume,source=$2,destination=/data/db" \
--env MONGO_INITDB_ROOT_USERNAME=user \
--env MONGO_INITDB_ROOT_PASSWORD=password \
mongo:latest &&
docker container start mongodbserver &&
docker container create \
--name mongodbexpress \
--network $3 \
--publish $1:8081 \
--env ME_CONFIG_MONGODB_URL="mongodb://user:password@mongodbserver:27017/" \
mongo-express:latest &&
docker container start mongodbexpress
