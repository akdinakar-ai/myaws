terraform {
  required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } }
}

resource "aws_security_group" "ec2" {
  name        = "${var.name}-ec2-sg"
  description = "EC2 security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data
  tags                        = merge(var.tags, { Name = var.name })
}

output "instance_id" { value = aws_instance.app.id }
output "security_group_id" { value = aws_security_group.ec2.id }
