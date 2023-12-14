#!/bin/bash
HOOK_URL="https://hooks.slack.com/services/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"
current_date_time=$(TZ='Asia/Seoul' date "+%Y년 %m월 %d일 %H시 %M분 %S초")
echo "현재 날짜와 시간: $current_date_time"

# Jenkins 서비스 상태 확인
jenkins_status=$(systemctl is-active jenkins)

message2="정상 작동 중"
# Jenkins 서비스가 활성화되어 있는지 확인
if [ "$jenkins_status" = "active" ]; then
    message="Jenkins 서비스가 활성화되어 있습니다."
else
    message="Jenkins 서비스가 활성화되어 있지 않습니다."
    systemctl restart jenkins
    message2="Jenkins 서비스를 재가동 합니다"
fi

echo $message
echo $message2
curl -X POST --data-urlencode "payload={\"channel\": \"#phk-alarm\", \"username\": \"PHK-TEST\", \"text\": \"$message\\n$message2\\n$current_date_time\", \"icon_emoji\": \":ghost:\"}" "$HOOK_URL"
}
