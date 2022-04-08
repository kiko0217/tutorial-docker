#!/bin/bash
# set -e
containsElement () {
  local e match="$1"
#   echo $e
#   echo $match
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

usage() {
    echo "usage: $0 namecontainer"
    exit 1
}
[[ $# -ne 1 ]] && usage
array=($(docker ps -a --format '{{.Names}}'))
containsElement "$"
# docker container rm contohredis
# echo $?
# array=( $( ls . ) )
# echo ${array[2]}
# for file in ${array[@]}
# do
#     echo $file
# done

# myvar=`ls`;
# echo $myvar
# for file in $myvar
# do
#     echo $file
# done

# for file in $(ls .)
# do
#     echo $file
# done
# [[ $? -ne 0 ]]
# containsElement "00-ls-lh.sh" "${array[@]}"
# echo $?