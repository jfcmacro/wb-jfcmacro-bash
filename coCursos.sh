#!/bin/bash

args=$*

if [[ ! (-x $HOME/bin/toSyncGen ) ]]
then
    echo "Sincronization is bad installed"
    exit 1
fi

export dirBaseName=Cursos
export repoLocation=$HOME/Dropbox
export workareaLocation=$HOME

toSyncGen $args
