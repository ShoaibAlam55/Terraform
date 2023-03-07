/*terraform {
  required_version = " 1.3.9"
}*/


resource "aws_vpc" "MyVpc"{
    cidr_block = var.VPCCidr
    instance_tenancy = "default"
    tags = {
      "name" = "MyVpc"
    }
  }

resource "aws_subnet" "mysubnet" {
    vpc_id = aws_vpc.MyVpc.id
    cidr_block = var.SubnetCidr
    tags = {
      "name" = "mysubnet"
    }
  }

  resource "aws_internet_gateway" "Myinternetgateway" {
    vpc_id = aws_vpc.MyVpc.id
    tags = {
        "name" = "Myinternetgateway"
    }
  }

  resource "aws_route_table" "Myroute" {
    vpc_id = aws_vpc.MyVpc.id

    route {
        cidr_block = "0.0.0.0/0"
        //in the route we are using internet gateway gateway_id = aws_internet_gateway.Myinternetgateway.id, for such route cidr_block must be 0.0.0.0/0 but not aws_subnet.mysubnet.cidr_block
        gateway_id = aws_internet_gateway.Myinternetgateway.id
    }
      tags = {
    Name = "Myroute"
  }
  }

  resource "aws_security_group" "MysecurityGroup" {
    name ="Mysecurity"
    description = "This security group created for VPC module"

    ingress {
        from_port = 80
        protocol    = "TCP"
        to_port     = 80
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
     from_port   = 22
     protocol    = "TCP"
     to_port     = 22
     cidr_blocks = ["0.0.0.0/0"]      
    }

    egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  }