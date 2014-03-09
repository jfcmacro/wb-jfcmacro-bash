#!/bin/bash

cd $HOME

# expected variables
# dirBaseName : directory to Syn
# repoLocation : pathname of the repository    (origin)
# workareaLocation : pathname of the work area (destine)

if [[ -z $dirBaseName ]]
then
    echo "dirNameToSyn variable is not defined"
    exit 1
fi

if [[ -z $repoLocation ]]
then
    echo "repoLocation variable is not defined"
    exit 1
fi

if [[ -z $workareaLocation ]]
then
    echo "workareLocation variable is not defined"
    exit 1
fi

if [ $1 ]
then
   if [ ! -e $repoLocation/$dirBaseName/$1 ]
   then
       echo "There is not a $repoLocation/$dirBaseName/$1"
       exit 0
   fi
   oriPathname=$repoLocation/$dirBaseName/$1/*
   dstPathname=$workareaLocation/$dirBaseName/$1
else
   oriPathname=$repoLocation/$dirBaseName/*
   dstPathname=$workareaLocation/$dirBaseName/$1
fi

echo "origin: ${oriPathname} dest: ${dstPathname}"
rsync --verbose --recursive --times --no-links --delete --exclude "*bak" --exclude "*~"  ${oriPathname} ${dstPathname}
