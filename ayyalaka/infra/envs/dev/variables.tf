variable "env" { type = string default = "dev" }
variable "region" { type = string default = "us-east-1" }
variable "vpc_cidr" { type = string default = "10.0.0.0/16" }
variable "public_subnet_cidrs" { type = list(string) default = ["10.0.1.0/24", "10.0.2.0/24"] }
variable "private_subnet_cidrs" { type = list(string) default = ["10.0.101.0/24", "10.0.102.0/24"] }
variable "azs" { type = list(string) default = ["us-east-1a", "us-east-1b"] }
variable "ami_id" { type = string description = "AMI for EC2 (e.g., Amazon Linux 2)" }
variable "instance_type" { type = string default = "t3.micro" }
variable "db_username" { type = string }
variable "db_password" { type = string sensitive = true }
variable "enable_https" { type = bool default = false }
variable "certificate_arn" { type = string default = null }
