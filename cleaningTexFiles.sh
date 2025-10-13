#!/usr/bin/bash

for i in $(svn status | grep "^?" | sed 's/^\? *//g' | sed 's/\..*$//g' | sort -u); do
    file=$i.tex
    if [ -e $file ]; then
	emacs --script $HOME/Workbench/wb-jfcmacro-elisp/cleanTeXFiles.el $file
    fi
done
	    
