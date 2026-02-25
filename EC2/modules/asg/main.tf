resource "aws_launch_template" "asg_lt" {
  name_prefix            = var.lt_name_prefix
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.instance_sg_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.instance_tag_name
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name = var.asg_name

  launch_template {
    id      = aws_launch_template.asg_lt.id
    version = "$Latest"
  }

  min_size            = var.asg_capacity
  max_size            = var.asg_capacity
  desired_capacity    = var.asg_capacity
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.tg_arn]

  tag {
    key                 = "Name"
    value               = var.instance_tag_name
    propagate_at_launch = true
  }
}