#!/usr/bin/bash

file=$1

if [ -f $file ]
then

    filename=`basename $file .pdf`
    
    course=`echo $filename | sed 's/-/ /g' | awk '{ print $1; }'`
    year=`echo $filename | sed 's/-/ /g' | awk '{ print $2; }'`
    term=`echo $filename | sed 's/-/ /g' | awk '{ print $3; }'`
    
    courselower=`echo $course | awk '{ print tolower($0) }'`

    publishDir=$HOME/Dropbox/Cursos/$courselower/$year/$term/Presentaciones
    
    if [ ! -d $publishDir ]
    then
	mkdir $publishDir
	echo "Creating directory $publishDir"
    fi
else
    echo "File: $file doesn't exits"
fi

cp $file $publishDir
