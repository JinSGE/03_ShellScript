#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 2
fi
FILE=$1

FILESIZE=$(wc -c < $FILE)

if [ $FILESIZE -gt 5120 ]; then
    echo "$FILE($FILESIZE): 5120 bytes 보다 큰 파일입니다."
elif [ $FILESIZE -le 5120 ]; then
    echo "$FILE($FILESIZE): 5120 bytes 이하인 파일입니다."
else
    echo "[ FAIL ] $FILE($FILESIZE) 사이즈가 잘못되었습니다."
fi
