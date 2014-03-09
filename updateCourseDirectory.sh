#!/bin/bash

currDir=`pwd`
maxYear=2000

for i in 20[0-9][0-9]
do
   if [ $maxYear -lt $i ]
   then
      maxYear=$i
   fi
done

maxTerm=1

for i in $maxYear/[1-2]
do
  if [ $marTerm -lt $i ]
  then
     maxTerm=$i
  fi
done

newDir=$maxYear/$maxTerm
echo $newDir

for i in *
do
  if [ -L "$i" ]
  then
      echo "$i"
      rm "$i"
      if [ -e $newDir/$i ]
      then
         ln -s $newDir/$i $i
      fi
  fi
done

echo $currDir
