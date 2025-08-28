#!/bin/bash
#
# useradd -c EMAIL USER
# echo PASSWORD | passwd --stdin USER
#

BASEDIR=/root/bin
USERDIR=$BASEDIR/users
USEROKDIR=$BASEDIR/users.completed

FILELIST=/tmp/tmp1

# 1) 파일 목록(/root/bin/users/*.txt) 만들기
ls -1 $USERDIR/*.txt > $FILELIST
for FILE in $(cat $FILELIST)
do
    echo
    UNAME=$(cat $FILE | grep '^username:' | awk -F: '{print $2}')
    UPASS=$(cat $FILE | grep '^password:' | awk -F: '{print $2}')
    EMAIL=$(cat $FILE | grep '^email:'    | awk -F: '{print $2}')

    useradd -c "$EMAIL" "$UNAME" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $UNAME"
        echo "$UPASS" | passwd --stdin "$UNAME" >/devnull 2>&1
    else
        echo "[ FAIL ] $UNAME"
        exit 2
    fi
done
