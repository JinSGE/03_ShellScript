#!/bin/bash
#
# Variable Definitions
#
PASSWD=/etc/passwd

#
# Function Definitions
#
_Menu() {
    cat << EOF

(관리 목록)
------------------------------------
1) 사용자 추가
2) 사용자 확인
3) 사용자 삭제
4) 종료
------------------------------------
EOF
}

_Error() {
   echo "[ FAIL ] 잘못된 번호를 입력하였습니다." 
}

_UserAdd() {
    echo
    echo "(사용자 추가)"
    echo -n "추가할 사용자 이름? : "
    read UNAME

    useradd $UNAME >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "------------------------------------"
        echo "[  OK  ] 정상적으로 추가 되었습니다.      "
        echo "------------------------------------"

        echo $UNAME | passwd --stdin $UNAME >/dev/null 2>&1
    else
        echo "------------------------------------"
        echo "[ FAIL ] 정상적으로 추가 되지 않았습니다.  "
        echo "------------------------------------"
    fi
}

_UserVerify() {
    echo 
    echo "(사용자 확인)"
    echo "------------------------------------"
    awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' $PASSWD | nl | sed 's/^    //'
    echo "------------------------------------"
}

_UserDel() {
    echo 
    echo "(사용자 삭제)"
    echo -n "삭제할 사용자 이름? : "
    read UNAME

    userdel -r $UNAME >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "------------------------------------"
        echo "[  OK  ] 정상적으로 삭제 되었습니다.      "
        echo "------------------------------------"
    else
        echo "------------------------------------"
        echo "[ FAIL ] 정상적으로 삭제 되지 않았습니다.  "
        echo "------------------------------------"
    fi
}

#
# Main Function
#
while true
do
    _Menu
    echo -n "선택 번호(1|2|3|4)? : "
    read NUM

    case "$NUM" in
        1) _UserAdd    ;;
        2) _UserVerify ;;
        3) _UserDel    ;;
        4) break       ;;
        *) _Error      ;;
    esac
done
