module "backend" {
  source = "../../../modules/dynamo_db"

  billing_mode        = var.billing_mode
  hash_key            = var.hash_key
  attribute_name      = var.attribute_name
  attribute_type      = var.attribute_type

  environment         = var.environment
  region              = var.region
  stack               = var.stack
}