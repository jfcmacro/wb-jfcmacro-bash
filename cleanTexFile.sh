#!/usr/bin/env bash

for i in $@
do
    if [ -f $i ]
    then
	yes | emacs "$i" --user $USER --batch -l ~/lib/emacs-batch/cleanTeXFile.el 1>/dev/null 2>&1
    fi
done
