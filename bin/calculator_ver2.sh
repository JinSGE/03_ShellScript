#!/bin/bash

echo -n "Enter A : "
read A

echo -n "Operator: "
read OP

echo -n "Enter B : "
read B

case $OP in
    '+') echo "$A + $B = $(expr $A + $B)"  ;;
    '-') echo "$A - $B = $(expr $A - $B)"  ;;
    'x') echo "$A x $B = $(expr $A \* $B)" ;;
    '/') echo "$A / $B = $(expr $A / $B)"  ;;
    *)   echo "[ FAIL ] 잘못된 $OP를 입력하였습니다." 
         exit 1 ;;
esac
