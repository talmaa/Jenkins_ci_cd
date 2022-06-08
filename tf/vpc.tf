resource "aws_vpc" "example" {
  cidr_block = "172.10.0.0/20"
  enable_dns_hostnames = true
}

resource "aws_subnet" "example-a" {
  vpc_id = "${aws_vpc.example.id}"
  cidr_block = "172.10.0.0/24"
  availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "example-c" {
  vpc_id = "${aws_vpc.example.id}"
  cidr_block = "172.10.1.0/24"
  availability_zone = "ap-northeast-2c"
}

// internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.example.id
}

// EIP for NAT gw
resource "aws_eip" "nat" {
  vpc = true
}

// NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.example-a.id
}