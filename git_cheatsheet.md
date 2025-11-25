# Git Cheatsheet

## 🔥 필수 3단계: 변경사항을 GitHub에 반영하기

```bash
git add .
git commit -m "update" # "update 대신에 뭘 업데이트 했는지에 대해서 설명하는 라인 쓰면 됨
git push


# 최근 커밋 로그 보기
git log --oneline

# 상세 커밋 로그 보기
git log

# 특정 파일의 커밋 로그
git log <파일명>
# example: git log data_loader.py

# VScode에서 보기
좌측의 source cotnrol - view - git graph 