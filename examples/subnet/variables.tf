variable "key_file" {
  default = "harik8-Ohio"
}

variable "map_public_ip_on_launch" {
  default = true
}

variable "nat_instance_type" {
  default = "t2.nano"
}

variable "private_cidr" {
  default = "10.0.0.0/24"
}

variable "public_cidr" {
  default = "10.0.100.0/24"
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