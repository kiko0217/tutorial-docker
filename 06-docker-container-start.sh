#!/bin/bash
set -e

usage() {
    echo "usage: $0 namecontainer"
    exit 1
}
[[ $# -ne 1 ]] && usage

docker container start $1