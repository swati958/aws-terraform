resource "aws_vpc" "app_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "App-VPC"
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "Public-Subnet-2"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.4.0/24"  # Changed from 10.0.3.0/24 to 10.0.4.0/24
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private-Subnet"
  }
}
