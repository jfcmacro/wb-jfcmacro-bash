#!/bin/bash

docStart=9726
docEnd=$[docEnd - 30]
fn="Apologetica"
fe=".mp3"
url=http://direct.aciprensa.com/podcast/download.php?file=

while [ $docStart > $docEnd ]
do
    filename=$fn$docStart$fe
    wget  -o $filename $url$docStart
    docStart=$[docStart - 1]
done
