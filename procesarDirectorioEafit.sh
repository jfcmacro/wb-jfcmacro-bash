#!/usr/bin/env bash

# sed '/^\s*$/d' |
directory=$(dirname $1)
filename=$(basename $1 .raw)
cat $1 | sed 's/Extensi/\'$'\n Extensi/g' | sed 's/Cumple/\'$'\n Cumple/g' | sed 's/E-mail/\'$'\n E-mail/g' | sed 's:\t::g' | sed 's/^ .*: */,/g' | sed 's/^\s*$/=/g' | tr '\n' ' ' | sed 's/=/\'$'\n/g' | cat > $directory/$filename.csv

