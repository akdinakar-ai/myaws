variable "name" { type = string }
variable "log_group_name" { type = string }
variable "retention_days" { type = number default = 14 }
variable "tags" { type = map(string) default = {} }
