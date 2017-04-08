#!/bin/bash

#
# pre: This script must be run with root user.
# post: This script does work with hidden files and directories.
# date: 07/12/2011
# programmer: Juan Francisco Cardona McCormick
#

recursive_part() {
   local i
   echo $*
   cd "$*"
   for i in .* *
   do
       if [ "$i" != "." ] ; then
          if [ "$i" != ".." ] ; then
             if [ "$i" != ".*" ] ; then
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
             fi
          fi
       fi
   done
}

recursive_part $*
