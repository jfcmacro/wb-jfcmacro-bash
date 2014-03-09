#!/bin/bash

args=$*

if [[ ! (-x $HOME/bin/toSyncGen ) ]]
then
    echo "Sincronization is bad installed"
    exit 1
fi

export dirBaseName=Programas
export repoLocation=$HOME
export workareaLocation=$HOME/Dropbox

toSyncGen $args
