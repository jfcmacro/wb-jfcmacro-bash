#!/usr/bin/env bash

directory=$(dirname $1)
filename=$(basename $1 .csv)
cat $1 | sed '/\-\-/d' | sed '/Secreta/d' | sed '/Profesor/p' | gawk -vFPAT='[^,]*|"[^"]*"' '{print $7}' | sort | uniq | cat > $directory/$filename.email
