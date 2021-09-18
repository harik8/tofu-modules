variable "acl" {
  default = "private"
}

variable "block_public_acls" {
  default = true
}

variable "block_public_policy" {
  default = true
}

variable "ignore_public_acls" {
  default = true
}

variable "kms_master_key_id" {
  default = "aws/s3"
}

variable "sse_algorithm" {
  default = "AES256"
}

variable "versioning" {
  default = true
}

variable "environment" {
  default = "test"
}

variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-east-1"
}

variable "stack" {
  default = "example"
}