#!/bin/bash

containsElement() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

usage() {
    echo usage: $0 source_mount volume
    exit 1
}

notexist() {
    echo $2 volume not exist!!
    exist
}

[[ $# -ne 2 ]] && usage || echo backupdata mongodb
array=($(docker volume ls --format '{{.Name}}'))
containsElement $2 "${array[@]}"
[[ $? -ne 0 ]] && notexist || echo $2 volume exist, start backup
[[ ! -d $1 ]] && mkdir -p $1
docker container create \
--name backupnginx \
--mount "type=bind,source=$1,destination=/backup" \
--mount "type=volume,source=$2,destination=/data" \
nginx:latest &&
docker container start backupnginx &&
docker container exec backupnginx /bin/bash -c "tar cvf /backup/backup.tar.gz /data"
docker container stop backupnginx &&
docker container rm backupnginx
