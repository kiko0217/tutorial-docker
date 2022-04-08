#!/bin/bash


usage() {
    echo usage: $0 container_name app
    exit 1
}

[[ $# -ne 2 ]] && usage
docker container exec -it $1 $2