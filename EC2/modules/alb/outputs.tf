output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.asg_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.asg_alb.arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.asg_tg.arn
}

output "listener_arn" {
  description = "ARN of the listener"
  value       = aws_lb_listener.asg_listener.arn
}