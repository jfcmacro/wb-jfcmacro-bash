#!/bin/bash

for i in `ls`
do
   if [ -d "$i" ]; then
      cd "$i"
      echo "$i"
      cd ..
   fi
done
