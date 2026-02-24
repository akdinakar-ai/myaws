variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnet1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "subnet1_az" {
  description = "Availability zone for subnet 1"
  type        = string
}

variable "subnet2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "subnet2_az" {
  description = "Availability zone for subnet 2"
  type        = string
}