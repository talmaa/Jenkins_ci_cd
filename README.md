README.md
# Jenkins_ci_cd

## Pipeline
```bash
- source commit -> github upload -> aws jenkins build trigger
-> aws jenkins docker build -> aws Registry registration
```

```
aws
.ec2 18.236.246.xxx 22
Docker
├──jenkins/jenkins:lts 8080
└──registry:latest 5000
```
## Command
```
sudo apt-get update

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER

docker network create aws_service

docker-compose up --build

^C

sudo chown -R 1000:1000 jenkins-data

sudo chown -R 1000:1000 jenkins-docker-certs

docker-compose up --build -d


```

## Public key pair
```
ssh-keygen -m PEM -f [키경로] -q N ""

dir

[키].key       <-- 내가 EC2에 접속 할때 쓰는 키
[키].key.pub   <-- 내가 클라우드 키페어에 등록하는 키 
```