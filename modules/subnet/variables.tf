#===============================#
#         MODULE VARS           #
#===============================#
variable "igw_id" {}
variable "key_file" {}
variable "nat_instance_ami" {}

variable "nat_instance_type" {}

variable "map_public_ip_on_launch" {}
variable "private_cidr" {}

variable "public_cidr" {}

variable "vpc_id" {}

#===============================#
#         COMMON VARS           #
#===============================#

variable "region" {}

variable "stack" {}

variable "environment" {}