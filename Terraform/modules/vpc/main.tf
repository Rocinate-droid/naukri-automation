resource "aws_vpc" "s3-vpc" {
  cidr_block = "10.0.2.0/24"
  tags = {
    name = "s3-vpc"
  }
}

resource "aws_subnet" "s3-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.s3-vpc.id
  tags = {
    name = "s3-subnet"
  }
}

resource "aws_route_table" "s3-route-table" {
  vpc_id = aws_vpc.s3-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.s3-igw.id
  }
  tags = {
    name = "s3-route-table"
  }
}

resource "aws_route_table_association" "s3-route-association" {
  route_table_id = aws_route_table.s3-route-table.id
  subnet_id = aws_subnet.s3-subnet.id
}

resource "aws_internet_gateway" "s3-igw" {
  vpc_id = aws_vpc.s3-vpc.id
  tags = {
    name = "s3-igw"
  }
}