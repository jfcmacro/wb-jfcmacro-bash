#!/usr/bin/bash
#
# purpose: it takes mosaic from eafit's sirena mosaic and
#          it copies from the clipboard to processing the student
#          info into the stdinfo format.
# env:     none
# depends: executables: procesarSirenaMosaico
#                       eafitCVSInfo2StdInfo
#                       xclip

# usage function
function usage {
    echo "Usage: $1 <coursename> <courseid> [<year> <term>]"
    exit 1
}

# compTerm function.
# It gets the correct term base on current date
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
