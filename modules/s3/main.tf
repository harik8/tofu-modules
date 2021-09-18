resource "aws_s3_bucket" "self" {
  bucket = "${local.default_tag}-tfstate"
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
#        kms_master_key_id = var.kms_master_key_id
        sse_algorithm     = var.sse_algorithm
      }
    }
  }

  tags = {
    Name = "${local.default_tag}-tfstate"
  }
}

resource "aws_s3_bucket_public_access_block" "self" {
  bucket = aws_s3_bucket.self.id

  block_public_acls   = var.block_public_acls
  block_public_policy = var.block_public_policy
  ignore_public_acls  = var.ignore_public_acls
}