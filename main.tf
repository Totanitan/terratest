terraform{
  required_providers {
    aws ={
      source ="hashicorp/aws"
      version = "~> 4"
    } 
  }
  required_version =">=1.0.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-handson"
  }
}

resource "aws_subnet" "aws-tf-public-subnet" {
    vpc_id           = aws_vpc.main.id
    cidr_block      = "10.0.0.0/24"
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

resource "aws_instance" "hello" {
  ami = "ami-0701e21c502689c31"
  instance_type = "t3.micro"
  tags = {
    Name = "test_instance"
  }
}