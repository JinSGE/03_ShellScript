#!/bin/bash

echo -n "파일 이름 입력? : "
read FILENAME

# echo $FILENAME
if [ -f "$FILENAME" ]; then
    echo "[  OK  ] 일반 파일입니다."
elif [ -d "$FILENAME" ]; then
    echo "[  OK  ] 디렉토리 파일입니다."
else
    echo "[ FAIL ] 잘못된 파일입니다."
    exit 1
fi
