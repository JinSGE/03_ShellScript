#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <pattern> <filename>"
    exit 1
fi
PATTERN=$1
FILENAME=$2
# echo "$PATTERN - $FILENAME"

grep -q "$PATTERN" "$FILENAME"
if [ $? -eq 0 ] ; then
    echo "[  OK  ] $FILENAME 파일에서 $PATTERN을 찾았습니다."
else
    echo "[ FAIL ] $FILENAME 파일에서 $PATTERN을 못 찾았습니다."
fi
