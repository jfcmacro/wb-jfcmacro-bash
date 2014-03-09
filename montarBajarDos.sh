#!/bin/bash

mount /mnt/floppy
cp -R /mnt/floppy/* .
umount /mnt/floppy
