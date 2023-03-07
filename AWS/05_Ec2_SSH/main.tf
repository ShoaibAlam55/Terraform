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

resource "aws_instance" "ec2_terraformDemo" {
    ami           = "ami-0b828c1c5ac3f13ee"
    instance_type = var.InstanceType
    key_name = "keys"
    vpc_security_group_ids = [aws_security_group.demo-securitygroup.id]  // it is set of string so need to be add under []
 provisioner "file" {
    source =    "E:\\Learning\\Terraform\\05_Ec2_SSH\\DemoFile.txt"  // Localhost directory where we have store the file
    destination = "/home/ubuntu/DemoFile.txt"  // Remote machine location where we will be storing the file
 }
 connection {
   type = "ssh"
   host = self.public_ip
   user = "ubuntu"
   private_key = file("E:\\Learning\\Terraform\\05_Ec2_SSH\\keys")
   timeout     = "4m"
 }
}

resource "aws_security_group" "demo-securitygroup" {
  name =   "Ec2 Security group"
  egress = [
     {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
        cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "TCP"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
  
}

resource "aws_key_pair" "keys" {
    key_name = "keys"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhe3HoYbroDFx80UXCXyyDrVy+FqtblYb1jlsTGEiYmtNX3js7gTSH2CYuga7R8BYNEr8inrzpxu0E3ryIrhI3M3Drt0gQ0uQkbrQF8buqlb/UaZOcB1el8pHtDAnOZGqFxD06kcssByIbWIB9vib5YIM/4g9BPotyG2nFCiZbWL4LNkfqYVorCCKJTDzq8PMEolz1gOCVnHHuT/uHMO8cs5IWfQpCNXEDwTLyAvQbgbtEpqqibtAOij4JDDgOntLHYwZyHOYohS/FZfh34iDBJofHqhJKjhAiIkDUhxUxWy2SFMKjSWDwuDBqwtQ9mIyZzVxzMcIlA2mKzCrHKDEB shoaib@LAPTOP-3LDLMHKV"
   // create public and private key using ssh keygen command. So that you can use private key while accessing the Ec2
}

variable "InstanceType" {
    description = "Instance type for EC2 machine"
    type = string
    default = "t1.micro"
  
}