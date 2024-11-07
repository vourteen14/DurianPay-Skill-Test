resource "aws_vpc" "durianpay-vpc" {
  cidr_block              = "10.0.0.0/16"
  enable_dns_support      = true
  enable_dns_hostnames    = true
}

resource "aws_subnet" "durianpay-subnet-public" {
  vpc_id                  = aws_vpc.durianpay-vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "durianpay-subnet-private" {
  vpc_id                  = aws_vpc.durianpay-vpc.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "us-east-1a"
}

resource "aws_internet_gateway" "durianpay-igw" {
  vpc_id                  = aws_vpc.durianpay-vpc.id
}

resource "aws_route_table" "durianpay-route-table-public" {
  vpc_id                  = aws_vpc.durianpay-vpc.id
  route {
    cidr_block            = "0.0.0.0/0"
    gateway_id            = aws_internet_gateway.durianpay-igw.id
  }
}

resource "aws_route_table_association" "durianpay-route-table-association-public" {
  subnet_id               = aws_subnet.durianpay-subnet-public.id
  route_table_id          = aws_route_table.durianpay-route-table-public.id
}

resource "aws_eip" "durianpay-eip" {
  domain                  = "vpc"
}

resource "aws_nat_gateway" "durianpay-nat" {
  allocation_id           = aws_eip.durianpay-eip.id
  subnet_id               = aws_subnet.durianpay-subnet-public.id
}

resource "aws_route_table" "durianpay-route-table-private" {
  vpc_id                  = aws_vpc.durianpay-vpc.id
  route {
    cidr_block            = "0.0.0.0/0"
    nat_gateway_id        = aws_nat_gateway.durianpay-nat.id
  }
}

resource "aws_route_table_association" "durianpay-route-table-association-private" {
  subnet_id               = aws_subnet.durianpay-subnet-private.id
  route_table_id          = aws_route_table.durianpay-route-table-private.id
}