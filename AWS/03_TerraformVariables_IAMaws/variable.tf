

variable "InstanceType" {
  description = "Tye of instance"
  type        = string
  //default     = "t2.micro"
}

variable "intsance_count" {
  description = "Number of instance created by terraform"
  type        = number
  //default     = 2

}
variable "userTerra" {
  description = "User's creating by terraform"
  type        = list(string)
  //default     = ["frist", "second", "third"]

}

variable "userGroup" {
  description = "user group created by terraform"
  type        = string
  //default     = "demoUserGroup"
}