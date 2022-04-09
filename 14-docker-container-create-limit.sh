#!/bin/bash

usage() {
    echo usage: $0 container_name image cpu_limit memory_limit
    exit 1
}

[[ $# -ne 4 ]] && usage || echo create container $1 with cpu=$3 and memory=$4

docker container create --name $1 --cpus $3 --memory $4 $2