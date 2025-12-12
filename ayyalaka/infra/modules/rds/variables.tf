variable "name" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "allowed_cidrs" { type = list(string) }
variable "engine" { type = string default = "mysql" }
variable "engine_version" { type = string default = "8.0" }
variable "instance_class" { type = string default = "db.t3.micro" }
variable "username" { type = string }
variable "password" { type = string }
variable "tags" { type = map(string) default = {} }
