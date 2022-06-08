resource "aws_key_pair" "deployer" {
  key_name = "deployer-key" 
  public_key = file("C:/Users/TALMA/Documents/rsa/docker.key.pub")
}

variable "key_pair" {
  default = "outsider-aws"
}

resource "aws_instance" "example-server" {
    ami = "ami-0225bc2990c54ce9a" # ubuntu 20.04 (64bit, x86)
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = ["${aws_security_group.example-allow-all.id}"]
    key_name = aws_key_pair.deployer.key_name

    tags = {
      Name = "Docker"
    }

    depends_on = [aws_internet_gateway.igw]
}