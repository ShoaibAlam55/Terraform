output "VpcID" {
    value = aws_vpc.MyVpc.arn
  
}

output "SubnetID" {
    value = aws_subnet.mysubnet.id
  
}