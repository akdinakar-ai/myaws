# ayyalaka / myDevOps - AWS IaC with Terraform

This repository scaffolds AWS infrastructure for learning and experimentation.

It contains Terraform configurations for multiple components and example
environments covering VPC, EC2, ALB, S3, RDS, CloudWatch, Grafana, and EKS.

## Prerequisites

- Terraform >= 1.0 (1.6 recommended for newer features)
- AWS account with programmatic access (Access Key + Secret) or OIDC setup for GitHub Actions

## Layout

- `EC2/` - modules and configs for ALB, ASG, security groups, and VPC
- `EKS/` - EKS cluster and VPC configurations
- `.github/workflows/` - CI pipelines

## Quick start (local)

```bash
cd /Users/dinnu/Downloads/myDevOps
terraform init
terraform fmt -recursive
terraform validate
```

For environment-specific usage follow files under each environment/module folder.

## CI

This repo includes a GitHub Actions workflow at `.github/workflows/terraform-ci.yml` that runs `terraform fmt` and `terraform validate` on PRs and pushes to `main`.

## Branch protection

See `BRANCH_PROTECTION.md` for instructions to enable branch protection rules for `main` (recommend requiring PR reviews and passing status checks).

## Next steps

- Add dashboards in Grafana pointing to CloudWatch Logs Insights queries.
- Expand modules (NAT Gateway, private ALBs, multi-AZ RDS).

## License

Add a license as needed.
<<<<<<< HEAD
# ayyalaka AWS IaC with Terraform

This repository scaffolds AWS infrastructure for learning and experimentation aligned with AWS SAA topics:
- VPC with public/private subnets and IGW
- EC2 instance behind an Application Load Balancer (ALB)
- S3 bucket with versioning and SSE
- RDS (MySQL) in private subnets
- CloudWatch Logs for EC2
- Amazon Managed Grafana workspace with CloudWatch datasource
- GitHub Actions CI for Terraform fmt/validate/plan and scheduled plans

## Prerequisites
- Terraform >= 1.6
- AWS account with programmatic access (Access Key + Secret) and permissions for VPC, EC2, ALB, S3, RDS, CloudWatch, Grafana.
- On Windows PowerShell (`pwsh`), set AWS credentials via environment variables or GitHub Actions secrets.

## Structure
- `infra/modules/*` reusable Terraform modules
- `infra/envs/dev` environment composition
- `.github/workflows/*` CI pipelines

## Usage (local)
1. Configure variables in `infra/envs/dev/variables.tf` (AMI id, DB creds).
2. Initialize and plan:

```powershell
cd C:\dev\ayyalaka\infra\envs\dev
terraform init
terraform plan -var "ami_id=ami-xxxxxxxx" -var "db_username=admin" -var "db_password=YourStrongP@ssw0rd"
```

3. Apply when ready:

```powershell
terraform apply -auto-approve -var "ami_id=ami-xxxxxxxx" -var "db_username=admin" -var "db_password=YourStrongP@ssw0rd"
```

Outputs:
- ALB DNS: `alb_dns`
- Grafana endpoint: `grafana_endpoint`

## GitHub Actions
Workflows use OpenID Connect (OIDC) or long-lived keys (prefer OIDC). Set repository secrets:
- `AWS_ACCOUNT_ID`, `AWS_ROLE_TO_ASSUME`, `AWS_REGION` (if using OIDC)
- OR `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`

## Next steps
- Add dashboards in Grafana pointing to CloudWatch Logs Insights queries.
- Expand modules (NAT Gateway, private ALBs, multi-AZ RDS).
=======
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
>>>>>>> work-save
