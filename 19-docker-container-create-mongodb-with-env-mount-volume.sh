#!/bin/bash

containsElement() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

usage() {
    echo usage: $0 container_name port_forwarding root_username root_password volume
    exit 1
}
notexist() {
    echo $5 volume not exist, create volume
    docker volume create $5
}

[[ $# -ne 5 ]] && usage || echo create $1 mongodb with username $2
array=($(docker volume ls --format '{{.Name}}'))
containsElement $5 "${array[@]}"
[[ $? -ne 0 ]] && notexist || echo $5 volume exist, create container
docker container create \
--name $1 \
--publish $2:27017 \
--env MONGO_INITDB_ROOT_USERNAME=$3 \
--env MONGO_INITDB_ROOT_PASSWORD=$4 \
--mount "type=volume,source=$5,destination=/data/db" \
mongo:latest
