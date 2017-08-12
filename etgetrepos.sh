#!/bin/env bash

# date: 11/08/2017
#

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
	ln -s $HOME/$1 $HOME/$2
    else
	if [ -d $ALTHOME/$USERNAME/$1 ]
	then
            ln -s $ALTHOME/$USERNAME/$1 $HOME/$2
	fi
    fi
}

while getopts ":ir:u:p:" opt; do
    case $opt in
	i)
	    echo "installing etgetrepos"
	    ;;
	r)
	    echo "Repository: $OPTARG"
	    ;;
	u)
	    echo "User: $OPTARG"
	    ;;
	p)  echo "Prefix: $OPTARG"
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    exit 1
	    ;;
	:)
	    echo "Option -$OPTARG requires an argument." >&2
	    exit 1
	    ;;
    esac
done

exit 0

cd $HOME

if [ -z "${JAVA_HOME+x}" ]
then
    echo "export JAVA_HOME=/cygdrive/c/Program\ Files/Java/jdk1.8.0/" >> .bashrc
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> .bashrc
    source .bashrc
fi


for i in bin lib share include
do
    createDir $i
done

linkDir AppData appdata
linkDir Documents docs
linkDir Desktop escritorio
linkDir Downloads descargas

if ! [ -x "$(ewe)" ]
then 
    echo "Installing ewe last version, it takes few minutes"
    cabal update
    cabal install ewe
    echo "export PATH=\$HOME/appdata/Roaming/cabal/bin:\$PATH" >> .bashrc
    source .bashrc
fi

createDir st0244

cd $HOME/st0244

if [ -z ${REPO+x} ]
then
    svn co https://svn.riouxsvn.com/2447$USERNAME --username $USERNAME
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
    cd 2447$USERNAME
else
    cd $REPO
fi

createSvnDirGo clases
# createSvnDirGo clase08

# This must be erased
# wget http://www1.eafit.edu.co/fcardona/examples/archives/aas.zip
# unzip aas.zip
# svn add *.java
# rm -f aas.zip

# exec bash
