module "backend" {
  source = "../../../modules/s3"

  acl                 = var.acl
  block_public_acls   = var.block_public_acls
  block_public_policy = var.block_public_policy
  ignore_public_acls  = var.ignore_public_acls
  kms_master_key_id   = var.kms_master_key_id
  sse_algorithm       = var.sse_algorithm
  versioning          = var.versioning

  environment         = var.environment
  region              = var.region
  stack               = var.stack
}