# vpc
resource "aws_vpc" "main" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

# public subnets
resource "aws_subnet" "publicSubnet-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "publicSubnet-1"
  }
}

resource "aws_subnet" "publicSubnet-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "publicSubnet-1"
  }
}

# private subnets
resource "aws_subnet" "privateSubnet-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "privateSubnet-1"
  }
}

resource "aws_subnet" "privateSubnet-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "privateSubnet-2"
  }
}

resource "aws_subnet" "privateSubnet-3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "privateSubnet-13"
  }
}

resource "aws_subnet" "privateSubnet-4" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "privateSubnet-4"
  }
}

#internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet-gateway"
  }
}