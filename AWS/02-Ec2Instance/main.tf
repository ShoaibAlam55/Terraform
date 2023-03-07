terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.54.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1" // Select the region where you want to create resources
  access_key = "***********************"  // Provide Access key here from AWS account
  secret_key = "********************************"  // Provide secret key here from AWS account
}


resource "aws_resourcegroups_group" "test" {
  name = "test-group"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::EC2::Instance"
  ],
  "TagFilters": [
    {
      "Key": "Stage",
      "Values": ["Test"]
    }
  ]
}
JSON
  }
}

resource "aws_instance" "demoec2" {
  
  ami = "ami-06ee4e2261a4dc5c3"
  instance_type = "t2.micro"

    tags = {
            Name = "Terraform EC2 demo"
        }
}

output "grouparn" {
    value = aws_resourcegroups_group.test.arn  
}

output "ec2name" {
    value = aws_instance.demoec2.public_ip
}