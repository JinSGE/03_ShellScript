#!/bin/bash

USERLIST=/root/bin/user.list

cat $USERLIST | while read UNAME UPASS
do
    userdel -r $UNAME \
        && echo "[  OK  ] $UNAME" \
        || echo "[ FAIL ] $UNAME"
done
