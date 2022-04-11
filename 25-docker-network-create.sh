#!/bin/bash

usage() {
    echo usage: $0 driver_name network_name
    exit 1
}

[[ $# -ne 2 ]] && usage || echo create $2 with driver $1
docker network create --driver $1 $2