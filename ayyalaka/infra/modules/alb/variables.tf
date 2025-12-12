variable "name" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "instance_id" { type = string }
variable "tags" { type = map(string) default = {} }
variable "enable_https" { type = bool default = false }
variable "certificate_arn" { type = string default = null }
