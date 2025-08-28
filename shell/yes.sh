#!/bin/bash

echo -n "yes/no를 입력하시오(yes/no)? : "
read YESNO

case $YESNO in
    yes|YES|Yes|y|Y) echo "[ INFO ] YES-MAN" ;;
    no|NO|No|n|N)    echo "[ INFO ] NO-MAN"  ;;
    *) echo "[ FAIL ] 잘못된 입력입니다."
       exit 1 ;;
esac
