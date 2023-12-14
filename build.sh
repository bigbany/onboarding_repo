#!/bin/bash


# 도커 이미지 빌드
docker build -t jenkins:latest .

# 기존 컨테이너가 실행 중이라면 종료 및 삭제
if [ "$(docker ps -a -f name=jenkins_container)" ]; then
  echo "기존에 실행 중인 jenkins_container 컨테이너를 종료하고 삭제합니다."
  docker stop jenkins_container
  docker rm -f jenkins_container
fi

if [ $? -eq 0 ]; then
  echo "도커 이미지 빌드가 성공적으로 완료되었습니다."

  # 도커 컨테이너 실행
  docker run -it --privileged=true -d --name jenkins_container  -p 80:8080 jenkins:latest /sbin/init

  # 실행이 성공적으로 완료되었는지 확인
  if [ $? -eq 0 ]; then
    echo "도커 컨테이너가 성공적으로 실행되었습니다."
  else
    echo "도커 컨테이너 실행 중 오류가 발생했습니다."
  fi

else
  echo "도커 이미지 빌드 중 오류가 발생했습니다."
fi

# 도커 컨테이너에 접속
docker exec -it jenkins_container /bin/bash