#!/usr/bin/bash

# date: 01/04/2017
# 

function tolower {
    local mytolower=$(echo $1 | tr '[:upper:]' '[:lower:]')
    echo "$mytolower"
}

USERNAME=`id -un`
PREFIX="2447"
REPO="$PREFIX$USERNAME"
SUBJECT="ST0244"
SUBLOWER=$(tolower $SUBJECT)

function createDir {
    if [ ! -d $1 ]
    then
	mkdir $1
    fi
}

function createSvnDirGo {
    if [ ! -d $1 ]
    then
	svn mkdir $1 && cd $1
    else
	cd $1
    fi
}

function linkDir {
    ALTHOME=/cygdrive/c/Users
    if [ -d $HOME/$1 ]
    then
	if  [ ! -h $HOME/$2 ]; then
	    ln -s $HOME/$1  $HOME/$2 2>/dev/null
	fi
    else
	if [ -d $ALTHOME/$3/$1]; then
            if [ ! -h $HOME/$2 ]; then
                ln -s $ALTHOME/$3/$1  $HOME/$2 2>/dev/null
            fi
	fi
    fi
}

function usage {
    echo "       $1 -h" >&2
    echo "       $1 [-r <repo>] [-u <username>] [-p <prefix-repo>] [-s <subject> ]" >&2
    exit $2
}

function appendFile {
    echo $1 >> $2
}

progname=$0

while getopts "r:u:p:hs:" opt; do
    case $opt in
	r)
	    REPO=$OPTARG
	    ;;
	u)
	    USERNAME=$OPTARG
	    ;;
	p)
	    PREFIX=$OPTARG
	    ;;
	h)
	    usage $progname 0
	    ;;
	s)
	    SUBJECT=$OPTARG
	    SUBLOWER=$(tolower $SUBJECT)
	    ;;
	\?)
	    usage $progname 1
	    ;;
	:)
	    echo "Option -$OPTARG requires an argument." >&2
	    exit 1
	    ;;
    esac
done


if [ -z ${REPO} ]
then
    echo 'REPO variable is undefined'
    exit 1
fi

echo "Starting test"

cd $HOME/st0244

if [ -z "${REPO}" ]
then
    svn co https://svn.riouxsvn.com/$PREFIX$USERNAME --username $USERNAME
else
    svn co https://svn.riouxsvn.com/$REPO --username $USERNAME
fi

if [ "$?" -ne 0 ]
then
    echo "You don't have a valid repository on svnriouxsvn"
    exit 1
fi

if [ -z "${REPO}" ]
then
    cd $PREFIX$USERNAME
else
    cd $REPO
fi

if [ ! -d parciales ]
then
    svn mkdir parciales
fi

cd parciales

svn mkdir parcial01

cd parcial01

appendFile "Maquina: $HOSTNAME" .parcial01reg
appendFile "Usuario: $USERNAME" .parcial01reg
appendFile "OS: $OS" .parcial01reg
hora=$(date)
appendFile "Hora: $hora" .parcial01reg

svn add .parcial01reg

svn mkdir punto01 punto02 punto03 punto04

# which wget 2>/dev/null

# if [ "$?" -eq 0 ]
# then
#     wget http://www1.eafit.edu.co/fcardona/parcial02.zip

#     if [ "$?" -eq 0 ]
#     then
#        unzip parcial02.zip
#        rm parcial02.zip
#        svn add * 2>/dev/null
#     else
#         echo 'Problemas adicionando puntos del parcial'
#         echo 'Debe hacerlo manualmente'
#     fi
# fi

# cd ..

svn ci -m "Starting test log"

# cd $HOME/descargas

# which wget 2>/dev/null

# if [ "$?" -eq 0 ]
# then
#     wget http://www1.eafit.edu.co/fcardona/parcial02.pdf

#     if [ "$?" -ne 0 ]
#     then
#         echo "Problemas trayendo el parcial"
#         echo "Debe hacerlo manualmente"
#     fi
# fi
