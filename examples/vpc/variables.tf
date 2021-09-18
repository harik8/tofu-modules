variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}

variable "instance_tenancy" {
  default = "default"
}

variable "environment" {
  default = "test"
}

variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-east-2"
}

variable "stack" {
  default = "example"
}