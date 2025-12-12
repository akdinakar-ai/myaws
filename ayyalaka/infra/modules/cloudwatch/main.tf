terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Log group for application logs
resource "aws_cloudwatch_log_group" "app" {
  name              = var.log_group_name
  retention_in_days = var.retention_days
  tags              = var.tags
}

# IAM role for EC2 to write logs
resource "aws_iam_role" "ec2_cw" {
  name               = "${var.name}-ec2-cloudwatch-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals { type = "Service" identifiers = ["ec2.amazonaws.com"] }
  }
}

resource "aws_iam_role_policy_attachment" "cw_attach" {
  role       = aws_iam_role.ec2_cw.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name}-ec2-cloudwatch-profile"
  role = aws_iam_role.ec2_cw.name
}

output "log_group_name" { value = aws_cloudwatch_log_group.app.name }
output "instance_profile" { value = aws_iam_instance_profile.ec2_profile.name }
