#!/bin/bash

inFile=$1
outFile=/tmp/ctbh.$$

cat $inFile | sed 's/\[rail\]/\[handout\]/' > $outFile
cp $outFile $inFile
rm $outFile
