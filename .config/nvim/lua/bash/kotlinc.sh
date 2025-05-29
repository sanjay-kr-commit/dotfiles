#!/bin/bash

kotlinc $2 -include-runtime -d /dev/shm/main.jar &
pid=$!

sign="-"

while [[ -d "/proc/$pid" ]]; do
  echo -ne "\r$sign compiling code"
  case "$sign" in
  "|")
    sign="/"
    ;;
  "/")
    sign="-"
    ;;
  "-")
    sign="\\"
    ;;
  "\\")
    sign="|"
    ;;
  esac

  sleep 0.1
done

echo -ne "\rcompilation complete        \n"

cd /dev/shm/
kotlin main.jar
cd $1
rm /dev/shm/main.jar
