#!/bin/bash

lastYear=2013
lastTerm=1

dir=$1
newDir=$lastYear/$lastTerm/$dir

mkdir $newDir
ln -s $newDir $dir

