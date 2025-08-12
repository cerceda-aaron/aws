locals {
    common_tags = {
        ManagedBy = "Terraform"
        Project = "AWS"
    }
}

resource "aws_vpc" "custom-vpc" {
  cidr_block = "10.0.0.0/16" # Range of IP addresses - 65,536 addresses from 10.0.0.0 to 10.0.255.255
  tags = merge(local.common_tags, {
    Name = "Custom VPC"
  })
}

resource "aws_subnet" "custom-vpc-subnet" {
  vpc_id = aws_vpc.custom-vpc.id
  cidr_block = "10.0.0.0/24" # Range of IP addresses - 256 IP addresses

  tags = merge(local.common_tags, {
    Name = "Custom VPC Subnets"
  })
}

resource "aws_internet_gateway" "igw-vpc" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = merge(local.common_tags, {
    Name = "Custom Internet Gateway for the VPC"
  })
}

resource "aws_route_table" "route-table-vpc" {
  vpc_id = aws_vpc.custom-vpc.id

  route {
    cidr_block = "0.0.0.0/0" # all IP addresses anywhere on the internet
    gateway_id = aws_internet_gateway.igw-vpc.id
  }

  tags = merge(local.common_tags, {
    Name = "Custom Route Table for the VPC"
  })
}

resource "aws_route_table_association" "route-table-assoc" {
  subnet_id = aws_subnet.custom-vpc-subnet.id
  route_table_id = aws_route_table.route-table-vpc.id
}



