#!/usr/bin/bash

function usage {
    echo "Usage: $1 <coursename> <courseid> [<year> <term>]"
    exit 1
}

function compTerm {
    m=$(date +%m)
    if (( $m < 7 ))
    then
	echo "1"
    else
	echo "2"
    fi
}

if (( $# != 2 && $# != 4 ))
then
    usage $0
fi

COURSE=$1
ID=$2

if (( $# == 2 ))
then
    YEAR=$(date +%Y)
    TERM=$(compTerm)
else
    YEAR=$3
    TERM=$4
fi

groupfilename="$COURSE-$YEAR-$TERM-$ID"
echo $groupfilename
xclip -o | tee $groupfilename-raw.dat | procesarSirenaMosaico | tee $groupfilename-cne.dat | eafitCVSInfo2StdInfo | tee $groupfilename-stdinfo.dat
