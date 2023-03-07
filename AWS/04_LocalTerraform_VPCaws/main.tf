terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1" // Select the region where you want to create resources
  access_key = "***********************"  // Provide Access key here from AWS account
  secret_key = "********************************"  // Provide secret key here from AWS account
}


locals {
  environment = "Demo"
}

resource "aws_vpc" "Vpc_terraform_demo" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "${local.environment}-VPC"
  }
}

resource "aws_subnet" "subnet_terraform_demo" {
  vpc_id     = aws_vpc.Vpc_terraform_demo.id
  cidr_block = "10.0.1.0/24"
  tags = {
    name = "${local.environment} - subnet"
  }
}
// Creating Ec2 instance while passing instance type and count through variable
resource "aws_instance" "Ec2example" {
  ami           = "ami-06ee4e2261a4dc5c3"
  instance_type = var.InstanceType
  subnet_id     = aws_subnet.subnet_terraform_demo.id
  tags = {
    name = "${local.environment} - EC2"
  }

}

