#!/usr/bin/bash

for i in sesion*
do
    if [ -d $i ]
    then
        cd $i
        echo "Directory: $i"
        for j in *.tex
        do
            if [ -f $j ]
            then
                echo "Cleaning: $j"
                cleanTeXFile $j
            fi
        done
        cd ..
    fi
done
