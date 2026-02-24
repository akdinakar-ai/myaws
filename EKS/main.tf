provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
}

module "cluster" {
  source = "./cluster"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
}