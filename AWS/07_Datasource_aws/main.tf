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



resource "aws_instance" "Demo_Ec2" {
   ami = "ami-0b828c1c5ac3f13ee"
  instance_type = "t1.micro"
  tags = {
    Name = "Terraform demo Ec2"
  }
}

data "aws_instance" "Ec2_terraform_dataSource" {
    filter {
      name ="tag:Name"
      values =  ["Terraform demo Ec2"]
          }
    depends_on = [
      "aws_instance.Demo_Ec2"
    ]  
}

output "fetch_awsInstance_details_Ec2" {
    value = data.aws_instance.Ec2_terraform_dataSource.public_ip
  
}

output "fetch_awsInstance_details_all" {
    value = data.aws_instance.Ec2_terraform_dataSource
  
}
