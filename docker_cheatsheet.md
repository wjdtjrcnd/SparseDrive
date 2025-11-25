# 🐳 Docker Cheatsheet (Copy-Friendly Version)

Docker 환경에서 머신러닝/딥러닝 프로젝트를 실행할 때 자주 사용하는 명령들을  
**각 항목별 설명과 명령어가 하나의 복사 가능한 코드블록** 안에 들어있는 형태로 정리했습니다.

---

## 🚀 1. Docker Image Build

```bash
# Dockerfile이 있는 디렉토리에서 이미지 빌드
# <image_name>:<tag> 형태로 지정 가능
# 예시: sparsedrive:latest

docker build -t sparsedrive:latest .
```

---

## 📦 2. Docker Container Run (GPU 포함)

```bash
# GPU 전체 사용(--gpus all)
# NuScenes 데이터와 SparseDrive 코드 폴더를 호스트에서 컨테이너로 마운트하는 예시

docker run -it --gpus all \
    -v /mnt/hdd/nuscenes:/workspace/data/nuscenes \
    -v ~/SparseDrive:/workspace/SparseDrive \
    sparsedrive:latest
```

---

## 🔁 3. 실행 중 컨테이너 접속 (exec)

```bash
# 실행 중인 컨테이너 안으로 들어가기
# <container_id> 는 `docker ps`로 확인 가능

docker exec -it <container_id> /bin/bash
```

---

## ▶️ 4. 컨테이너 시작/재시작

```bash
# 중지된 컨테이너 시작
docker start <container_id>

# 재시작
docker restart <container_id>

# 시작 후 bash로 접속
docker exec -it <container_id> bash
```

---

## ⏹ 5. 컨테이너 종료 & 삭제

```bash
# 컨테이너 중지
docker stop <container_id>

# 컨테이너 삭제
docker rm <container_id>

# 강제 삭제 (중지+삭제)
docker rm -f <container_id>
```

---

## 🗂 6. Docker 이미지 관리

```bash
# 로컬 이미지 목록 확인
docker images

# 이미지 삭제
docker rmi <image_id>
```

---

## 📋 7. 컨테이너 목록 확인

```bash
# 실행 중인 컨테이너 목록
docker ps

# 전체 컨테이너 목록(중지 포함)
docker ps -a
```

---

## 📦 8. 컨테이너 ↔ 호스트 파일 복사

```bash
# 호스트 → 컨테이너
docker cp <local_path> <container_id>:<container_path>

# 컨테이너 → 호스트
docker cp <container_id>:<container_path> <local_path>
```

---

## 🧹 9. Docker 시스템 클린업

```bash
# 사용하지 않는 리소스 삭제
docker system prune

# 이미지/캐시 모두 제거(주의!)
docker system prune -a

# 사용하지 않는 볼륨 제거
docker volume prune
```

---

## 🧩 10. Docker Volume 관리

```bash
# 볼륨 목록
docker volume ls

# 특정 볼륨 삭제
docker volume rm <volume_name>
```

---

## 🔧 11. Dockerfile 이미지 테스트

```bash
# 이미지가 정상 실행되는지 테스트
docker run -it sparsedrive:latest /bin/bash
```

---

## ⭐ 가장 많이 쓰는 4줄 요약

```bash
docker build -t sparsedrive:latest .
docker run -it --gpus all -v ~/data:/workspace/data sparsedrive:latest
docker ps -a
docker exec -it <container_id> bash
```
