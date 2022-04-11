#!/bin/bash

containsElement() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}
usage() {
    echo usage: $0 dir_backup volume_will_backup
    exit 1
}
notexist() {
    echo $2 volume not exist!!
    exit 1
}

[[ $# -ne 2 ]] && usage
array=($(docker volume ls --format '{{.Name}}'))
containsElement $2 "${array[@]}"
[[ $? -ne 0 ]] && notexist || echo volume exist, start backup
[[ ! -d $1 ]] && mkdir -p $1
docker container run \
--rm \
--name ubuntubackup \
--mount "type=bind,source=$1,destination=/backup" \
--mount "type=volume,source=$2,destination=/data" \
ubuntu:latest tar cvf /backup/backup.tar.gz /data