variable "github_org" {
  description = "GitHub organization or user that will issue OIDC tokens"
  type        = string
  default     = "DIN"
}

variable "github_repo" {
  description = "GitHub repository name that will issue OIDC tokens"
  type        = string
  default     = "myaws"
}

variable "github_branch_pattern" {
  description = "Branch pattern (ref) to allow, e.g. refs/heads/main or refs/heads/*"
  type        = string
  default     = "refs/heads/*"
}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_iam_policy_document" "github_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_org}/${var.github_repo}:ref:${var.github_branch_pattern}"]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name               = "tf-github-actions-role"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}
