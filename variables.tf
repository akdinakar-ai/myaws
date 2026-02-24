variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet1_az" {
  description = "Availability zone for subnet 1"
  type        = string
  default     = "us-east-1a"
}

variable "subnet2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet2_az" {
  description = "Availability zone for subnet 2"
  type        = string
  default     = "us-east-1b"
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
  default     = "csec02"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_filter_values" {
  description = "AMI filter values for Amazon Linux 2"
  type        = list(string)
  default     = ["amzn2-ami-hvm-*-x86_64-gp2"]
}

variable "tg_name" {
  description = "Name of the target group"
  type        = string
  default     = "csec02-tg"
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "csec02-alb"
}

variable "lt_name_prefix" {
  description = "Name prefix for launch template"
  type        = string
  default     = "csec02-"
}

variable "instance_tag_name" {
  description = "Tag name for instances"
  type        = string
  default     = "csec02-instance"
}

variable "asg_capacity" {
  description = "Desired, min, and max capacity for ASG"
  type        = number
  default     = 3
}