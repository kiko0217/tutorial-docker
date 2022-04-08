#!/bin/bash

set -e
usage() {
    echo "usage: $0 namecontainer image"
    exit 1
}

[[ $# -ne 2 ]] && usage

docker container create --name $1 $2