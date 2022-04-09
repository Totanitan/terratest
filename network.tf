resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-handson"
  }
}

resource "aws_subnet" "aws-tf-public-subnet" {
    vpc_id           = aws_vpc.main.id
    cidr_block      = "10.0.0.0/24"
    availability_zone = "ap-northeast-1a"
    map_public_ip_on_launch = true
    
    tags = {
        Name = "aws-tf-public-subnet"
    }
}

resource "aws_subnet" "aws-tf-private-subnet" {
    vpc_id           = aws_vpc.main.id
    cidr_block      = "10.0.1.0/24"
    tags = {
        Name = "aws-tf-private-subnet"
    }
}

resource "aws_internet_gateway" "aws-tf-igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "aws-tf-igw"
  }
}

resource "aws_route_table" "aws-tf-rt" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "aws-tf-rt"
    }
}

resource "aws_route" "aws-route" {
    route_table_id = aws_route_table.aws-tf-rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-tf-igw.id
}

resource "aws_route_table_association" "example_route_table_a" {
    route_table_id = aws_route_table.aws-tf-rt.id
    subnet_id = aws_subnet.aws-tf-public-subnet.id
}