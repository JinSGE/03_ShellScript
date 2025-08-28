#!/bin/bash

echo -n "파일 이름 입력? : "
read FILENAME

echo
if [ -x "$FILENAME" ]; then
    $FILENAME
fi

