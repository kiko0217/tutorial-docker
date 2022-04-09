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
    exit 1zm
}
notexist() {
    echo $1 not exist
    exit 1
}
[[ $# -ne 1 ]] && usage
array=($(docker ps -a --format '{{.Names}}'))
containsElement $1 "${array[@]}"
[[ $? -ne 0 ]] && notexist
docker container rm $1 || (docker container stop $1 && docker container rm $1)
[[ $? -eq 0 ]] && echo remove $1 successfully || echo failed remove $1
# if [ $? -eq 0 ] 
# then
#     exit 0
# else
#     docker container stop $1 && docker container rm $1
#     if [ $? -ne 0 ]
#     then
#         exit 1
#     else
        
#         exit 0
#     fi
# fi 

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