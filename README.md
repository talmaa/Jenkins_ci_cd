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

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/