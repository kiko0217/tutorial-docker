#!/bin/bash

usage() {
    echo $0 namecontainer image portforwarding
    exit 1
}

[[ $# -ne 3 ]] && usage || echo create conatiner $1 dengan image $2 port forwarding $3

docker container create --name $1 --publish $3 $2