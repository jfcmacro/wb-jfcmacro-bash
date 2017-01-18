#!/usr/bin/bash

for i in $@
do
    if [ -f $i ]
    then
	yes | emacs "$i" --batch -l ~/lib/emacs-batch/cleanTeXFile.el
    fi
done
