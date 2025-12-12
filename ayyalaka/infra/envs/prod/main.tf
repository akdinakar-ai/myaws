terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws" version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.region
}

locals {
  tags = {
    Project = "ayyalaka"
    Env     = var.env
  }
}

module "vpc" {
  source               = "../../modules/vpc"
  name                 = "${var.env}-vpc"
  cidr_block           = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  tags                 = local.tags
}

module "cloudwatch" {
  source         = "../../modules/cloudwatch"
  name           = "${var.env}"
  log_group_name = "/ayyalaka/${var.env}/app"
  retention_days = 30
  tags           = local.tags
}

module "ec2" {
  source               = "../../modules/ec2"
  name                 = "${var.env}-app"
  vpc_id               = module.vpc.vpc_id
  subnet_id            = module.vpc.public_subnet_ids[0]
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  iam_instance_profile = module.cloudwatch.instance_profile
  user_data            = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y amazon-cloudwatch-agent
                cat <<CFG | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
                {
                  "logs": {
                    "logs_collected": {
                      "files": {
                        "collect_list": [
                          {"file_path": "/var/log/messages", "log_group_name": "${module.cloudwatch.log_group_name}", "log_stream_name": "ec2"}
                        ]
                      }
                    }
                  }
                }
                CFG
                sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start
                echo "hello prod" > /var/www/html/index.html
                nohup busybox httpd -f -p 80 &
                EOF
  tags                 = local.tags
}

module "alb" {
  source      = "../../modules/alb"
  name        = "${var.env}-alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  instance_id = module.ec2.instance_id
  enable_https   = var.enable_https
  certificate_arn = var.certificate_arn
  tags        = local.tags
}

module "s3" {
  source            = "../../modules/s3"
  bucket_name       = "ayyalaka-${var.env}-${random_id.bucket_id.hex}"
  enable_versioning = true
  tags              = local.tags
}

resource "random_id" "bucket_id" { byte_length = 4 }

module "rds" {
  source        = "../../modules/rds"
  name          = "${var.env}-db"
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnet_ids
  allowed_cidrs = [var.vpc_cidr]
  username      = var.db_username
  password      = var.db_password
  tags          = local.tags
}

module "grafana" {
  source = "../../modules/grafana"
  name   = "${var.env}-grafana"
  tags   = local.tags
}

output "alb_dns" { value = module.alb.alb_dns_name }
output "grafana_endpoint" { value = module.grafana.grafana_endpoint }
