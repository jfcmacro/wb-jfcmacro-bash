#!/bin/bash

outputDir=$HOME/Documentos/declaracion-2024
if [ ! -d  "$outputDir" ]; then
    mkdir "$outputDir"
fi

for i in *-2024; do
    pushd $i
    cp *.pdf $outputDir/
    popd
done
