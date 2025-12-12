terraform {
  required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } }
}

# Amazon Managed Grafana workspace
resource "aws_grafana_workspace" "this" {
  name                 = var.name
  account_access_type  = "CURRENT_ACCOUNT"
  authentication_providers = ["SAML", "SSO"]
  data_sources         = ["CLOUDWATCH"]
  tags                 = var.tags
}

# Permission to read CloudWatch metrics/logs via CloudWatch datasource is managed by Grafana workspace role.
# For log insights, ensure CloudWatch logs are present in the selected region.

output "grafana_workspace_id" { value = aws_grafana_workspace.this.id }
output "grafana_endpoint" { value = aws_grafana_workspace.this.endpoint }
