#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Moving files from $SCRIPTPATH to $HOME"

FilesToIgnore=( init.sh .git moveFiles.sh addAliases.sh )

args=" $SCRIPTPATH -mindepth 1 -maxdepth 1 "

for entry in ${FilesToIgnore[@]}
do 
  args="$args -not -name $entry"
done

FileCount=$( find $args )

if [[ ${#FileCount} -ne 0 ]]
then
  find $args -print0 | xargs -0 mv -t $HOME
  echo "Files moved"
else
  echo "Nothing to move"
fi
