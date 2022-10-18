#!/usr/bin/bash

baseDir=~/Workbench/epam-latam-s4n-fun-prog-c3/videos
srcDir=raw_videos
destDir=ready_pre_edition

prefix='EPAM-LATAM'
course_name='FP'
course='C3'
module='M0'
unit='U0'
video='V1'

cd $baseDir

pushd $destDir
preEditFiles=$(ls -lt | head -n 2 | tail -n 1 | cut -d ' ' -f 10)
popd

if [ -z $preEditFiles ]
then
    cNroPart=0
else
    cNroPart=$(echo $preEditFiles | cut -d '-' -f 8 | sed 's/P//g')
fi

nNroPart=$(expr $cNroPart + 1)
newPart="P$nNroPart"

echo "Creating videos $newPart"


pushd $srcDir
files=$(ls -lt | head -n 3 | tail -n 2 | awk '{ print $9; }')
newName="$prefix-$course_name-$course-$module-$unit-$video-$newPart"

for file in $files
do
    echo "$file $newName"
    if [ -f "$file" ]
    then
	if [[ $file == *"Docente"* ]]
	then
	    destFile=../$destDir/$newName-Docente.mp4
	    if [ ! -f $destFile ]
	    then
		echo "copy: $file ../$destDir/$newName-Docente.mp4"
		cp $file $destFile
	    else
		echo "ERROR: tratando de sobre escribir el video $destFile"
	    fi
	fi
	if [[ $file == *"Consola"* ]]
	then
	    destFile=../$destDir/$newName-Consola.mp4
	    if [ ! -f $destFile ]
	    then 
		echo "copy: $file ../$destDir/$newName-Consola.mp4"
		cp $file $destFile
	    else
		echo "ERROR: tratando de sobre escribir el video $destFile"
	    fi
	fi
    else
	echo "Don't exits $file"
    fi
done
popd
