output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.asg.name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.asg_lt.id
}