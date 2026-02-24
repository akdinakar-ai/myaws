provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = var.ami_filter_values
  }
}

terraform {
  backend "s3" {
    bucket         = "ayyalaka-terraform-backend-2026"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}

module "vpc" {
  source = "./EC2/modules/vpc"

  vpc_cidr     = var.vpc_cidr
  subnet1_cidr = var.subnet1_cidr
  subnet1_az   = var.subnet1_az
  subnet2_cidr = var.subnet2_cidr
  subnet2_az   = var.subnet2_az
}

module "security_groups" {
  source = "./EC2/modules/security_groups"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./EC2/modules/alb"

  alb_name   = var.alb_name
  vpc_id     = module.vpc.vpc_id
  subnet_ids = [module.vpc.subnet1_id, module.vpc.subnet2_id]
  alb_sg_id  = module.security_groups.alb_sg_id
  tg_name    = var.tg_name
}

module "asg" {
  source = "./EC2/modules/asg"

  asg_name          = var.asg_name
  lt_name_prefix    = var.lt_name_prefix
  instance_type     = var.instance_type
  ami_id            = data.aws_ami.amazon_linux.id
  instance_sg_id    = module.security_groups.instance_sg_id
  subnet_ids        = [module.vpc.subnet1_id, module.vpc.subnet2_id]
  tg_arn            = module.alb.target_group_arn
  asg_capacity      = var.asg_capacity
  instance_tag_name = var.instance_tag_name
}

# Backend resources
resource "aws_s3_bucket" "backend" {
  bucket = "ayyalaka-terraform-backend-2026"
}

resource "aws_dynamodb_table" "backend" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}