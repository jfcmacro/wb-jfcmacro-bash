#!/bin/bash
# Scriptname: copiarFileIn.sh

name=$2
dn=`dirname $2`
fn=`basename $2`
dm=`echo $dn | sed 's/\//\_/g' | sed 's/ /_/g' `

nname="$1/$dm$fn"

echo "Directorio: $1 Archivo: $2 Nuevo Nombre: $nname"

cp "$name" $nname 
