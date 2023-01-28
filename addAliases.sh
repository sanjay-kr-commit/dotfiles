#!/bin/bash

echo "Adding alias for this repo"

path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/.git"

echo "Everytime you move dir or change dir name you'll need to run this file"

echo "alias dotfile='git --git-dir=$path --work-tree=$HOME'" > $HOME/.dotfileRepoAliases

git --git-dir=$path config --local status.showUntrackedFiles no

Entry=$(cat $HOME/.bashrc | grep ".dotfileRepoAliases" )
Entry=${#Entry}

if [[ $Entry -eq 0 ]] 
then
  echo "
if [ -f ~/.dotfileRepoAliases ]; then
    . ~/.dotfileRepoAliases
fi
  " >> $HOME/.bashrc
fi

Entry=$(cat $HOME/.zshrc | grep ".dotfileRepoAliases" )
Entry=${#Entry}

if [[ $Entry -eq 0 ]] 
then
  echo "
if [ -f ~/.dotfileRepoAliases ]; then
    . ~/.dotfileRepoAliases
fi
  " >> $HOME/.zshrc
fi

echo "Use dotfile to add files present in home directory"
echo "Restart Terminal"
