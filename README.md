# myDevOps

This repository contains Terraform configurations for AWS infrastructure, including EC2 and EKS modules.

## Layout

- `EC2/` - modules and configs for ALB, ASG, security groups, and VPC
- `EKS/` - EKS cluster and VPC configurations

## Quick start

Install Terraform (>= 1.0) and run:

```bash
cd /Users/dinnu/Downloads/myDevOps
terraform init
terraform fmt -recursive
terraform validate
```

## CI

This repo includes a GitHub Actions workflow at `.github/workflows/terraform-ci.yml` that runs `terraform fmt` and `terraform validate` on PRs and pushes to `main`.

## Branch protection

See `BRANCH_PROTECTION.md` for instructions to enable branch protection rules for `main` (recommend requiring PR reviews and passing status checks).

## License

Add a license as needed.
