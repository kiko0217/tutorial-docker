#!/bin/bash

containsElement() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

usage() {
    echo usage: $0 volume_name
    exit 1
}
notexist() {
    echo $1 not exist
    exit 1
}
[[ $# -ne 1 ]] && usage || echo delete $1
array=($(docker volume ls --format '{{.Name}}'))
containsElement $1 "${array[@]}"
[[ $? -ne 0 ]] && notexist || echo $1 exist
docker volume rm $1
[[ $? -eq 0 ]] && echo remove volume $1 successfully || echo failed remove volume $1