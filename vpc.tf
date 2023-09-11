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

  tags = {
    Name = "publicSubnet-1"
  }
}

resource "aws_subnet" "publicSubnet-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "publicSubnet-1"
  }
}