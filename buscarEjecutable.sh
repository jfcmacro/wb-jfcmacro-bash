#!/bin/bash

for i in `echo $PATH | sed 's/:/ /g'`
do
    for j in $i/*pm*
    do
	if [ -x $j ]
	then
	    ls $j
	fi
    done
done
