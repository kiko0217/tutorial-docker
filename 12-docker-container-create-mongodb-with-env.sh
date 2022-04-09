#!/bin/bash

usage() {
    echo usage: $0 container_name port_forwarding root_username root_password
    exit 1
}

[[ $# -ne 4 ]] && usage || echo create $1 mongodb with username $2

docker container create --name $1 --publish $2:27017 --env MONGO_INITDB_ROOT_USERNAME=$3 --env MONGO_INITDB_ROOT_PASSWORD=$4 mongo:latest