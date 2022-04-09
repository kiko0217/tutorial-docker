#!/bin/bash

usage() {
    echo usage: $0 container_name port_forwarding root_username root_password source_mount 
    exit 1
}

[[ $# -ne 5 ]] && usage || echo create $1 mongodb with username $2
[[ ! -d $5 ]] && mkdir -p $5
docker container create \
--name $1 \
--publish $2:27017 \
--env MONGO_INITDB_ROOT_USERNAME=$3 \
--env MONGO_INITDB_ROOT_PASSWORD=$4 \
--mount "type=bind,source=$5,destination=/data/db" \
mongo:latest