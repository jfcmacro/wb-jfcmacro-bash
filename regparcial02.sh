#!/usr/bin/bash

# date: 01/04/2017
#

cd $HOME/st0244

if [ -n ${REPO+x} ]
then
    if [ -d $REPO ]
    then
        cd $REPO
    else
        echo "No se pudo hacer el registro hacerlo manualmente"
        exit 1
    fi
else
    echo "No hay variable REPO definida"
    exit 2
fi

cd parciales/parcial02

echo "Registro final"     >> .parcial02reg
echo "Maquina: $HOSTNAME" >> .parcial02reg
echo "Usuario: $USERNAME" >> .parcial02reg
echo "OS: $OS" >> .parcial02reg
hora=$(date)
echo "Hora: $hora" >> .parcial02reg

svn add .parcial02reg 2>/dev/null

svn ci -m "Registro de final parcial"
