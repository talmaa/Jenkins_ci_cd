FROM jenkins/jenkins:2.339-jdk11

USER root

## docker 설치
#RUN curl -s https://get.docker.com/ | sh

## docker-compose 설치
#RUN curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
#    chmod +x /usr/local/bin/docker-compose && \
#    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

## dcs 툴 설치
#RUN curl -sL bit.ly/ralf_dcs -o ./dcs && \
#    chmod 755 dcs && \
#    mv dcs /usr/local/bin/dcs

#RUN usermod -aG docker jenkins

# install docker-cli
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

#
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.1 docker-workflow:1.26"