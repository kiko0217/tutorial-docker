#!/bin/bash

containsElement() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}
usage() {
    echo usage: $0 backup_file volume_restore
    exit 1
}
fileNotExist() {
    echo file $1 not exist!!
    exit 1
}
createVolumeRestore() {
    docker volume create $1
}
[[ $# -ne 2 ]] && usage || echo checking $1
[[ ! -f $1 ]] && fileNotExist || echo file $1 exist, checking volume $2
array=($(docker volume ls --format '{{.Name}}'))
containsElement $2 "${array[@]}"
[[ $? -ne 0 ]] && createVolumeRestore $2 || echo volume $2 exist
docker container run \
--rm \
--name ubunturestore \
--mount "type=bind,source=$(dirname $1),destination=/backup" \
--mount "type=volume,source=$2,destination=/data" \
ubuntu:latest /bin/bash -c "cd /data && tar xvf /backup/$(basename $1) --strip 1"