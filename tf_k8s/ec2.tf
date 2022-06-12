resource "aws_key_pair" "deployer" {
  key_name = "deployer-key" 
  public_key = file("C:/Users/TALMA/Documents/rsa/docker.key.pub")
}

variable "key_pair" {
  default = "outsider-aws"
}

resource "aws_instance" "master-server" {
    ami = "ami-063454de5fe8eba79" # ubuntu 22.04 (64bit, x86)
    instance_type = "t3.small"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.example-allow-all.id]
    key_name = aws_key_pair.deployer.key_name

    user_data = <<-EOF
      #! /bin/bash
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
      sudo apt-get -y install docker-ce docker-ce-cli containerd.io
      sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      sudo usermod -aG docker ubuntu

      sudo apt install net-tools

      swapoff -a

      sudo apt-get update
      sudo apt-get install -y apt-transport-https ca-certificates curl

      sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

      echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

      sudo apt-get update
      sudo apt-get install -y kubelet kubeadm kubectl
      sudo apt-mark hold kubelet kubeadm kubectl

      systemctl daemon-reload
      systemctl restart kubelet
      systemctl enable kubelet

      sudo chown ubuntu:ubuntu /etc/kubernetes/admin.conf
      echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /home/ubuntu/.bashrc

    EOF

    tags = {
      Name = "Master"
    }

    depends_on = [aws_internet_gateway.igw]
}

resource "aws_instance" "node1-server" {
    ami = "ami-063454de5fe8eba79" # ubuntu 22.04 (64bit, x86)
    instance_type = "t3.small"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.example-allow-all.id]
    key_name = aws_key_pair.deployer.key_name

    user_data = <<-EOF
      #! /bin/bash
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
      sudo apt-get -y install docker-ce docker-ce-cli containerd.io
      sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      sudo usermod -aG docker ubuntu

      swapoff -a

      sudo apt-get update
      sudo apt-get install -y apt-transport-https ca-certificates curl

      sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

      echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

      sudo apt-get update
      sudo apt-get install -y kubelet kubeadm kubectl
      sudo apt-mark hold kubelet kubeadm kubectl

    EOF

    tags = {
      Name = "Node1"
    }

    depends_on = [aws_internet_gateway.igw]
}

resource "aws_instance" "node2-server" {
    ami = "ami-063454de5fe8eba79" # ubuntu 22.04 (64bit, x86)
    instance_type = "t3.small"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.example-allow-all.id]
    key_name = aws_key_pair.deployer.key_name

    user_data = <<-EOF
      #! /bin/bash
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
      sudo apt-get -y install docker-ce docker-ce-cli containerd.io
      sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      sudo usermod -aG docker ubuntu

      swapoff -a

      sudo apt-get update
      sudo apt-get install -y apt-transport-https ca-certificates curl

      sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

      echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

      sudo apt-get update
      sudo apt-get install -y kubelet kubeadm kubectl
      sudo apt-mark hold kubelet kubeadm kubectl

      systemctl daemon-reload
      systemctl restart kubelet
      
    EOF

    tags = {
      Name = "Node2"
    }

    depends_on = [aws_internet_gateway.igw]
}