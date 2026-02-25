resource "aws_iam_policy" "tf_ec2_alb_asg_limited" {
  name = "tf-ec2-alb-asg-limited"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:Describe*",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:CreateTags",
          "elasticloadbalancing:Create*",
          "elasticloadbalancing:Delete*",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets",
          "autoscaling:CreateAutoScalingGroup",
          "autoscaling:UpdateAutoScalingGroup",
          "autoscaling:DeleteAutoScalingGroup",
          "autoscaling:Describe*",
          "iam:PassRole"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketVersioning",
          "s3:GetBucket*",
          "s3:GetBucketWebsite",
          "s3:GetBucketVersioning",
          "s3:GetBucketLogging",
          "s3:GetBucketEncryption",
          "s3:GetBucketPolicyStatus",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy"
        ],
        Resource = [
          aws_s3_bucket.backend.arn,
          "${aws_s3_bucket.backend.arn}/*"
        ]
      },
        {
          Effect = "Allow",
          Action = [
            "s3:GetAccelerateConfiguration"
          ],
          Resource = [
            aws_s3_bucket.backend.arn
          ]
        },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:DescribeTable",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:ListTagsOfResource",
          "dynamodb:DeleteItem"
        ],
        Resource = aws_dynamodb_table.backend.arn
      }
    ]
  })
}


resource "aws_iam_policy" "tf_oidc_read" {
  name   = "tf-oidc-read"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "iam:GetOpenIDConnectProvider",
          "iam:GetRole",
          "iam:ListAttachedRolePolicies",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:ListRolePolicies",
          "iam:GetRolePolicy"
        ],
        Resource = [
          "arn:aws:iam::901635709382:oidc-provider/token.actions.githubusercontent.com",
          "arn:aws:iam::901635709382:role/tf-github-actions-role",
          "arn:aws:iam::901635709382:policy/tf-oidc-read"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_oidc_read" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.tf_oidc_read.arn
}
resource "aws_iam_role_policy_attachment" "attach_tf_policy" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.tf_ec2_alb_asg_limited.arn
}
