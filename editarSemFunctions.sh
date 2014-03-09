#!/bin/bash

cat $1 | sed 's/_.*::.*$//g' | sed '/LINE/d' | sed '/src\/Sem/d' | sed '/[ ]*)[ ]*$/d' | sed '/^[ ]*$/d' > /tmp/salida.tmp
mv /tmp/salida.tmp $1 
