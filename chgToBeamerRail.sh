#!/bin/bash

inFile=$1
outFile=/tmp/ctbh.$$

cat $inFile | sed 's/\[handout\]/\[rail\]/' > $outFile
cp $outFile $inFile
rm $outFile
