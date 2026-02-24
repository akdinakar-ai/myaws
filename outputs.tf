output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet1_id" {
  description = "ID of public subnet 1"
  value       = module.vpc.subnet1_id
}

output "subnet2_id" {
  description = "ID of public subnet 2"
  value       = module.vpc.subnet2_id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.alb.target_group_arn
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.asg.asg_name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = module.asg.launch_template_id
}

output "security_group_alb_id" {
  description = "ID of the ALB security group"
  value       = module.security_groups.alb_sg_id
}

output "security_group_instance_id" {
  description = "ID of the instance security group"
  value       = module.security_groups.instance_sg_id
}