#!/bin/bash

cat <<EOF
====================================================
  (1). who      (2). date     (3). pwd              
====================================================
EOF
echo -n "번호를 선택하시오? (1|2|3): "
read NUM

echo
case "$NUM" in
    1) who  ;;
    2) date ;;
    3) pwd  ;;
    *) echo "[ FAIL ] 잘못 입력 하셨습니다."
       exit 1 ;;
esac
echo
