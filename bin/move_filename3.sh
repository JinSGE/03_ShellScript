#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <directory> <src ext> <dest ext>"
    exit 1
fi
D_WORK=$1
EXT1=$2
EXT2=$3
T_FILE1=/tmp/.tmp1

ls -1 $D_WORK | grep ".$EXT1\$" > $T_FILE1
for FILE in `cat $T_FILE1`
do
    mv $D_WORK/$FILE `echo $D_WORK/$FILE | sed "s/.$EXT1\$/.$EXT2/g"`
done
