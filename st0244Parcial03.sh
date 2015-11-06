#!/usr/bin/env bash

WEBPAGE="http://www1.eafit.edu.co/fcardona/cursos/st0244/parcial03/"
# Getting Files
cd $HOME
curl $WEBPAGE/minttyrc > .minttyrc
curl $WEBPAGE/emacs > .emacs

if [ ! -d st0244 ]
then
    echo "Creating directory st0244"
    mkdir st0244
fi

cd st0244

echo "Preparing checkout..."
svn co https://svn.riouxsvn.com/244s$USERNAME --username $USERNAME
if [ ! -d 244s$USERNAME/parciales ]
then
    svn --parents mkdir 244s$USERNAME/parciales
fi

cd 244s$USERNAME/parciales/
if [ ! -d parcial03 ]
then
    svn mkdir parcial03
fi
cd parcial03
wget $WEBPAGE/parcial03.zip && unzip parcial03.zip && rm -f parcial03.zip
svn add *
echo "First checkout of parcial03"
svn ci -m "Inicio del parcial03"
