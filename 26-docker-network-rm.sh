#!/bin/bash

usage() {
    echo usage: $0 network_name
    exit 1
}

[[ $# -ne 1 ]] && usage || echo remove network $1

docker network rm $1