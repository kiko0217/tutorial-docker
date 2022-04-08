#!/bin/bash
# ini agar tidak exit terminal
set -e 
#buat fungsi cara mengunakan

usage() {
    echo "usage: $0 image:tag"
    exit 0
}
[[ $# -ne 1 ]] && usage
docker image pull $1