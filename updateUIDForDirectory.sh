#!/bin/bash

#
# pre: This script must be run with root user.
# post: this script doesn't work with hidden files and directories.
# date: 05/12/2011
# programmer: Juan Francisco Cardona McCormick
#

recursive_part() {
   local i
   echo $*
   cd "$*"
   for i in  *
   do
       if [ "$i" != "*" ] ; then
          file=`echo $i | sed 's/ /\\ /g'`
          chown fcardona "$file"
          chgrp fcardona "$file"
          echo $file
          if [ -d "$file" ] ; then
             recursive_part "$file"
             cd ..
          fi
       fi
   done
}

recursive_part $*
