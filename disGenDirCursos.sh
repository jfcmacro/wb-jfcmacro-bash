#!/bin/bash

year=`date +%Y`
month=`date +%m`
pwdtmp=`pwd`
course=`basename $pwdtmp`

case "$month" in
01) term=1
	;;
02) term=1
	;;
03) term=1
	;;
04) term=1
        ;;
05) term=1
	;;
06) term=1
	;;
07) term=2
	;;
08) term=2
	;;
09) term=2
	;;
10) term=2
        ;;
11) term=2
	;;
12) term=2
	;;
esac

echo "YEAR=$year"
echo "TERM=$term"
echo "COURSE=$course"

for i in "Notas" "Parciales" "Prácticas" "Programa" "Sesiones" "Talleres"
do
  dir=$year/$term/$i
  if [ ! -d $dir ]
  then
      echo "Creating $dir directory"
      mkdir -p $dir
      if [ -d $i ]
      then
          if [ -h $i ]
          then
              unlink $i
          fi
	  ln -s $dir $i
      fi
  else 
      if [ -d $i ]
      then 
	  if [ -h $i ]
          then
              unlink $i
          fi
	  ln -s $dir $i
      fi
  fi
done