variable "VPCCidr" {
  description ="Add the CIDR block"
  type = string
  default = "10.0.0.0/16"
}

variable "SubnetCidr" {
  description ="Add the CIDR block"
  type = string
  default = "10.0.1.0/24"
}