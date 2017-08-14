#!/usr/bin/bash

# date: 01/04/2017
# 

if [ -z ${REPO+x} ]
then
    echo 'Defina la variable REPO: export GRUPO=<REPONAME>'
    exit 1
fi

echo "Iniciando el parcial"

cd

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
    if [ ! -L $HOME/appdata ]
    then
	ln -s $HOME/AppData $HOME/appdata
    fi
else
    if [ -d /cygdrive/c/Users/$USERNAME/AppData ]
    then
	if [ ! -L $HOME/appdata ]
	then
            ln -s /cygdrive/c/Users/$USERNAME/AppData $HOME/appdata
	fi
    fi
fi

if [ -d $HOME/Documents ]
then
    if [ ! -L $HOME/docs ]
    then
	ln -s $HOME/Documents $HOME/docs
    fi
else
    if [ -d /cygdrive/c/Users/$USERNAME/Documents ]
    then
	if [ ! -L $HOME/docs ]
	then
           ln -s /cygdrive/c/Users/$USERNAME/Documents $HOME/docs
	fi
    fi
fi

if [ -d $HOME/Desktop ]
then
    if [ ! -L $HOME/escritorio ]
    then
	ln -s $HOME/Desktop $HOME/escritorio
    fi
else
    if [ -d /cygdrive/c/Users/$USERNAME/Desktop ]
    then
	if [ ! -L $HOME/escritorio ]
	then
           ln -s /cygdrive/c/Users/$USERNAME/Desktop $HOME/escritorio
	fi
    fi
fi

if [ -d $HOME/Downloads ]
then
    if [ ! -L $HOME/descargas ]
    then 
	ln -s $HOME/Downloads $HOME/descargas
    fi
else
    if [ -d /cygdrive/c/Users/$USERNAME/Downloads ]
    then
	if [ ! -L $HOME/descargas ]
	then
            ln -s /cygdrive/c/Users/$USERNAME/Downloads $HOME/descargas
	fi
    fi
fi

# cabal update
# cabal install ewe

# echo "export PATH=\$HOME/appdata/Roaming/cabal/bin:\$PATH" >> .profile
# source .profile

cd $HOME/st0244

if [ -n ${REPO+x} ]
then
    svn co https://svn.riouxsvn.com/$REPO --username $USERNAME
else
    svn co https://svn.riouxsvn.com/244$GRUPO$USERNAME --username $USERNAME
fi

if [ "$?" -ne 0 ]
then
    echo "Descargar el parcial manualmente o reintente nuevamente"
    exit 1
fi

cd 244$REPO

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
       svn add * 2>/dev/null
    else
        echo 'Problemas adicionando puntos del parcial'
        echo 'Debe hacerlo manualmente'
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
