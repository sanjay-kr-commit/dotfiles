#!/bin/bash
 
path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

bash $path/moveFiles.sh

bash $path/addAliases.sh
