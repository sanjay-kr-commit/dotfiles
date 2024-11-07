#!/bin/bash 

local SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source "$SCRIPTPATH/debug"

if [[ "$1" == "log" ]] ; then
  constructDebugger
fi 

# commment below line to stop sudo override
eval "source $SCRIPTPATH/runUserBinariesWithSudo/script"

# comment below line to disable push command
eval "source $SCRIPTPATH/gitPass/script"

# comment below line to disable flatpakAliases
eval "source $SCRIPTPATH/flatpakAliases/script"

# comment below line to remove syncTheme 
eval "source $SCRIPTPATH/syncThemeToRoot/script"

# comment below line to remove saveAlias and deleteAlias function 
eval "source $SCRIPTPATH/saveAlias/script"

if [[ "$2" != "persist" ]] ; then
  destructDebugger 
fi
