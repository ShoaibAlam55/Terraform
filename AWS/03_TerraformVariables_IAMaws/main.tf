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

// Creating Ec2 instance while passing instance type and count through variable
resource "aws_instance" "Ec2example" {
  count         = var.intsance_count
  ami           = "ami-06ee4e2261a4dc5c3"
  instance_type = var.InstanceType
  tags = {
    name = "Terraform Ec2 Vm"
  }

}

//Creating multiple IAM user through for_each loop and using values from variable
resource "aws_iam_user" "terraformUsers" {
 // count = length(var.userTerra)
 // name  = var.userTerra[count.index]
 for_each = toset(var.userTerra)
 name = each.value
}

// Creating user group to store the created multiple user 
resource "aws_iam_group" "terraformGroup1" {
  name = var.userGroup
}


// assgining  users the  user group which we created
resource "aws_iam_user_group_membership" "userGroupdemo" {
  for_each = toset(var.userTerra)
  user = aws_iam_user.terraformUsers[each.value].name
  groups = [
    aws_iam_group.terraformGroup1.name
  ]
}