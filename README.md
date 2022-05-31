# Jenkins_ci_cd

## Pipeline
```bash
- source commit -> github upload -> aws jenkins build trigger 
-> aws jenkins docker build -> aws Registry registration
```

```aws
.ec2 18.236.246.xxx 22
Docker
├──jenkins/jenkins:lts 8080
└──registry:latest 5000
```