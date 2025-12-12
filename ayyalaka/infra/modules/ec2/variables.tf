variable "name" { type = string }
variable "vpc_id" { type = string }
variable "subnet_id" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { type = string default = "t3.micro" }
variable "iam_instance_profile" { type = string }
variable "user_data" { type = string default = null }
variable "tags" { type = map(string) default = {} }
