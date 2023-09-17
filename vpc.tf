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
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "publicSubnet-1"
  }
}

resource "aws_subnet" "publicSubnet-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "publicSubnet-1"
  }
}

# private subnets
resource "aws_subnet" "privateSubnet-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "privateSubnet-1"
  }
}

resource "aws_subnet" "privateSubnet-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "privateSubnet-2"
  }
}

resource "aws_subnet" "privateSubnet-3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "privateSubnet-3"
  }
}

resource "aws_subnet" "privateSubnet-4" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "privateSubnet-4"
  }
}

# Internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet-gateway"
  }
}

# NAT Gateway and elastic IP address
resource "aws_eip" "nat_eip" {
  domain           = "vpc"
  depends_on = [aws_internet_gateway.ig]


  tags = {
    Name            = "nat-eip"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.publicSubnet-1.id
  depends_on    = [aws_internet_gateway.ig]


  tags = {
    Name            = "main-nat"
  }
}



# route table for public subnets
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name            = "Public-Route-Table"
  }
}

# route table association for public subnets
resource "aws_route" "public-rt-route" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}


resource "aws_route_table_association" "public-subnets-assoc-1" {
  subnet_id      = aws_subnet.publicSubnet-1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-subnets-assoc-2" {
  subnet_id      = aws_subnet.publicSubnet-2.id
  route_table_id = aws_route_table.public-rt.id
}



# private route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name            = "Private-Route-Table"
  }
}

# route table association for private subnet
resource "aws_route" "private-rt-route" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}


resource "aws_route_table_association" "private-subnets-assoc-1" {
  subnet_id      = aws_subnet.privateSubnet-1.id
  route_table_id = aws_route_table.private-rt.id
}


resource "aws_route_table_association" "private-subnets-assoc-2" {
  subnet_id      = aws_subnet.privateSubnet-2.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-subnets-assoc-3" {
  subnet_id      = aws_subnet.privateSubnet-3.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-subnets-assoc-4" {
  subnet_id      = aws_subnet.privateSubnet-4.id
  route_table_id = aws_route_table.private-rt.id
}