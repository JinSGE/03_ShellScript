#!/bin/bash
# gitpush.sh /project

# set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <repository>"
    exit 1
fi
DIR=$1      # ~/project
REPO=$2     # ShellScript

source ~/github_token.txt

# 0) 준비 사항
# 필수 패키지 설치
rpm -q git-core >/dev/null 2>&1 || yum -y -q install git-core

# 1) 레포지토리 생성
# curl -u "$GITUSER:$TOKEN" \
#     https://api.github.com/user/repos \
#     -d "{\"name\":\"$REPO\"}"

# 2) 프로젝트 디렉토리 구성
cat << EOF

#####################################################
* 프로젝트 디렉토리에 올리고 싶은 파일을 복사해 주세요.
* 제외할 파일이 있다면 .gitignore 파일에 등록해 주세요.
* 민감한 내용은 제외 시켜 주세요.
#####################################################

EOF
echo "아무키나 누르면 다음으로 진행합니다...."
read

echo -n "[ INFO ] 완료가 되었나요? (y/n): "
read ANSWER
case $ANSWER in
    y) echo "[  OK  ] 다음을 진행합니다." ;;
    *) echo "[ INFO ] 프로그램을 종료합니다."
       exit 2 ;;
esac

# README.md 파일 생성
mkdir -p "$DIR" && cd "$DIR"
echo "# $REPO" > $DIR/README.md

# git 폴더 초기화 
git init

# 계정 기본 신원 정보 설정
git config --global user.email "$EMAIL"
git config --global user.name "GITUSER"
git config --list 

# Commit 작업
git add .
git commit -m "COMMIT: $RANDOM"

# Branch 설정
git branch -M main
git branch

# Origin 설정
# REMOTE="https://github.com/$GITUSER/$REPO.git"
# REMOTE="git@github.com:$GITUSER/$REPO.git"
REMOTE="git@github.com:$GITID/$REPO.git"
if git remote get-url origin >/dev/null 2>&1; then
    echo "[ INFO ] 기존 origin이 존재합니다. URL을 변경합니다."
    git remote set-url origin "$REMOTE"
else
    echo "[ INFO ] origin이 없습니다. 새로 추가합니다."
    git remote add origin "$REMOTE"
fi
git remote -v

# Push 설정
git push -u origin main
