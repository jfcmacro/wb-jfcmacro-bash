#!/usr/bin/bash

while IFS= read -r line; do
    echo -n $line | sha256sum | base64 -w 0 -
    echo ""
done < $HOME/tmp/testSha256.in
