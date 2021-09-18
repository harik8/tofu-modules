resource "aws_dynamodb_table" "self" {
  name         = "${local.default_tag}-tflock"
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }

  tags = {
      Name = "${local.default_tag}-tflock"
    }
}