#!/bin/env bash

#
# date: 11/08/2017
# user: Juan Francisco Cardona Mc'Cormick (jfcmacro)
# purpose: This program create a directory hierarchy
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
	    ln -s $HOME/$1  $HOME/$2
	fi
    else
	if [ -d $ALTHOME/$3/$1 -a ! -h $HOME/$2 ]; then
            ln -s $ALTHOME/$3/$1  $HOME/$2
	fi
    fi
}

function usage {
    echo "Usage: $1 -i" >&2
    echo "       $1 -h" >&2
    echo "       $1 [-r <repo>] [-u <username>] [-p <prefix-repo>]" >&2
    exit $2
}

progname=$0

while getopts ":ir:u:p:hs:" opt; do
    case $opt in
	i)
	    echo "installing etgetrepos"
	    ;;
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

# exit 0

cd $HOME

if [ -z "${JAVA_HOME+x}" ]; then
    echo 'export JAVA_VERSION="1.8.0"' > .bashrc
    echo "export JAVA_HOME=/cygdrive/c/Program\ Files/Java/jdk$JAVA_VERSION/" >> .bashrc
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> .bashrc
    echo 'export CLASSPATH=".:\$CLASSPATH"' >> .bashrc
    . .bashrc
fi

for i in bin lib share include
do
    createDir $i
done

linkDir AppData appdata $USERNAME
linkDir Documents docs $USERNAME
linkDir Desktop escritorio $USERNAME
linkDir Downloads descargas $USERNAME

cd $HOME

if  [ ! -x "$(command -v ewe)" ]
then
    echo "Installing ewe last version, it takes few minutes"
    cabal update
    cabal install ewe --prefix $(cygpath -w $HOME)
    echo "export PATH=\$HOME/bin:\$PATH" >> .bashrc
    . .bashrc
fi

createDir st0244

cd $HOME/st0244

if [ -z ${REPO+x} ]
then
    svn co https://svn.riouxsvn.com/$PREFIX$USERNAME --username $USERNAME
else
    svn co https://svn.riouxsvn.com/$REPO --username $USERNAME
fi

if [ "$?" -ne 0 ]
then
    echo "You don't have a repository, please add a repository"
    exit 1
fi

if [ -z ${REPO+x} ]
then
    cd $PREFIX$USERNAME
else
    cd $REPO
fi

createSvnDirGo clases
