#!/usr/bin/bash

# date: 01/04/2017
#

if [ -z ${GRUPO+x} ]
then
    echo 'Defina la variable GRUPO: export GRUPO="0"'
    echo 'o export GRUPO="3"'
    echo 'o export GRUPO="4"'
    echo 'Segun el grupo que tiene asignado'
    echo 'Defina la variable TEMA: export TEMA="A"'
    echo 'o TEMA="B"'
    exit 1
fi

echo "Iniciando el parcial"

if [ ! -d bin ]
then
    mkdir bin
fi

if [ ! -d lib ]
then
    mkdir lib
fi

if [ ! -d include ]
then
    mkdir include
fi

if [ ! -d st0244 ]
then
    mkdir st0244
fi

if [ -d $HOME/AppData ]
then
    ln -s $HOME/AppData $HOME/appdata
else
    if [ -d /cygdrive/c/Users/$USERNAME/AppData ]
    then
        ln -s /cygdrive/c/Users/$USERNAME/AppData $HOME/appdata
    fi
fi

if [ -d $HOME/Documents ]
then
    ln -s $HOME/Documents $HOME/docs
else
    if [ -d /cygdrive/c/Users/$USERNAME/Documents ]
    then
        ln -s /cygdrive/c/Users/$USERNAME/Documents $HOME/docs
    fi
fi

if [ -d $HOME/Desktop ]
then
    ln -s $HOME/Desktop $HOME/escritorio
else
    if [ -d /cygdrive/c/Users/$USERNAME/Desktop ]
    then
        ln -s /cygdrive/c/Users/$USERNAME/Desktop $HOME/escritorio
    fi
fi

if [ -d $HOME/Downloads ]
then
    ln -s $HOME/Downloads $HOME/descargas
else
    if [ -d /cygdrive/c/Users/$USERNAME/Downloads ]
    then
        ln -s /cygdrive/c/Users/$USERNAME/Downloads $HOME/descargas
    fi
fi

cabal update
# cabal install ewe

echo "export PATH=\$HOME/appdata/Roaming/cabal/bin:\$PATH" >> .profile
source .profile

cd $HOME/st0244

svn co https://svn.riouxsvn.com/244$GRUPO$USERNAME --username $USERNAME

if [ "$?" -ne 0 ]
then
    echo "Usted tiene un problema para descargar el parcial debe hacerlo manualmente"
    exit 1
fi

cd 244$GRUPO$USERNAME

if [ ! -d parciales ]
then
    svn mkdir parciales
fi

cd parciales

svn mkdir parcial02

cd parcial02

echo "Maquina: $HOSTNAME" >> .parcial02reg
echo "Usuario: $USERNAME" >> .parcial02reg
echo "OS: $OS" >> .parcial02reg
hora=$(date)
echo "Hora: $hora" >> .parcial02reg

svn add .parcial02reg

which wget 2>/dev/null

if [ "$?" -eq 0 ]
then
    wget http://www1.eafit.edu.co/fcardona/parcial02.zip

    if [ "$?" -eq 0 ]
    then
       unzip parcial02.zip
       rm parcial02.zip
       svn add proccalc generador addmult
    else
        echo "Problemas adicionando puntos del parcial"
        echo "Debe hacerlo manualmente"
    fi
fi

cd ..

svn ci -m "Registro de inicio del parcial"

cd $HOME/descargas

which wget 2>/dev/null

if [ "$?" -eq 0 ]
then
    wget http://www1.eafit.edu.co/fcardona/parcial02.pdf

    if [ "$?" -ne 0 ]
    then
        echo "Problemas trayendo el parcial"
        echo "Debe hacerlo manualmente"
    fi
fi
