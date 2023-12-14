FROM ubuntu:20.04

ENV TZ Asia/Seoul
# 패키지 설치를 위한 사전 작업

ENV PYTHONIOENCODING UTF-8
ENV LC_CTYPE C.UTF-8

WORKDIR /root

RUN apt update -y && \
    apt install -y software-properties-common

# deadsnakes PPA에서 Python 3.7 설치
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt update -y && \
    apt install -y python3.7 python3.7-distutils

# Python 3.7을 기본 Python 3로 설정
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1 && \
    update-alternatives --set python3 /usr/bin/python3.7

# 나머지 부분은 유지

RUN apt install -y curl unzip vim sudo wget cron

RUN apt-get install -qq -y init systemd



RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

RUN useradd -ms /bin/bash phk && \
    echo "phk:12345678" | chpasswd

RUN echo 'export TEST=PHK' >> /root/.bashrc

RUN apt-get install -y  fontconfig openjdk-17-jre


RUN wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian/jenkins.io-2023.key

RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until

RUN apt-get update && \
    apt-get install -y jenkins

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN systemctl mask systemd

COPY run_check.sh /root/run_check.sh
RUN echo "*/5 * * * * /root/run_check.sh >> cron.log 2>&1" | crontab -

RUN curl -s https://get.docker.com | sh

RUN usermod -aG docker jenkins


CMD ["/usr/sbin/init"]
