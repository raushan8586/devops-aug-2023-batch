terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
}

#Create VPC
resource "aws_vpc" "intellipaat-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "intellipaat-vpc"
  }
}

#Create Subnet1
resource "aws_subnet" "Public-Subnet" {
  vpc_id     = aws_vpc.intellipaat-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public-Subnet"
  }
}

#Create Subnet2
resource "aws_subnet" "Private-Subnet" {
  vpc_id     = aws_vpc.intellipaat-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Private-Subnet"
  }
}

#Create IGW
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.intellipaat-vpc.id

  tags = {
    Name = "IGW"
  }
}

#Create EC2 Instance
resource "aws_instance" "intellipaat-instance" {
  ami                     = "ami-0f5ee92e2d63afc18"
  instance_type           = "t2.micro"
  key_name                = "devops-august-2023"
  subnet_id               = aws_subnet.Public-Subnet.id
  tags = {
    Name = "intellipaat-instance"
  }

}
