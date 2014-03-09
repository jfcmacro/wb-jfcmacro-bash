#!/bin/bash
# Scriptname: copiarFileIn.sh

dirname=$1
nname=`echo $2 | sed 's/\//_/g' | sed 's/\.//'`

echo "Salida: $2 => $nname"

cp "$2" $1/$nname
 
