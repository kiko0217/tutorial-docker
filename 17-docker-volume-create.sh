#!/bin/bash

usage() {
    echo usage: $0 volume_name
    exit 1
}

[[ $# -ne 1 ]] && usage || echo create volume $1

docker volume create $1