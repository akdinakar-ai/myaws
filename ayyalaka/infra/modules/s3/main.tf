terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration { status = var.enable_versioning ? "Enabled" : "Suspended" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.this.id
  rule { apply_server_side_encryption_by_default { sse_algorithm = "AES256" } }
}

output "bucket_name" { value = aws_s3_bucket.this.bucket }
