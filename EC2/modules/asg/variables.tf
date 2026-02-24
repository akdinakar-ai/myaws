variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "lt_name_prefix" {
  description = "Name prefix for launch template"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for instances"
  type        = string
}

variable "instance_sg_id" {
  description = "ID of the instance security group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "tg_arn" {
  description = "ARN of the target group"
  type        = string
}

variable "asg_capacity" {
  description = "Desired, min, and max capacity for ASG"
  type        = number
}

variable "instance_tag_name" {
  description = "Tag name for instances"
  type        = string
}