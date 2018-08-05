#!/usr/bin/bash

# Parameters:
# $1: Oldname
# $2: Newname
# $3: OldExtension
# $4: NewExtension
# $5: Finish sequence
# $6: Start sequence
function changeOldName {
    local oldName=$1
    local newName=$2
    for i in $(seq -f "%02g" $6 $5)
    do
        svn mv ${oldName}${i}${3} ${newName}${i}${4}
    done
}

changeOldName $1 $2 $3 $4 $5 $6
