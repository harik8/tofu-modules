#===============================#
#         MODULE VARS           #
#===============================#

variable "core_dns_version" {}
variable "eks_version" {}
variable "endpoint_private_access" {}
variable "endpoint_public_access" {}

variable "kube_proxy_version" {}
variable "subnet_ids" {}
variable "vpc_cidr" {}

variable "vpc_cni_version" {}
variable "vpc_id" {}

#===============================#
#         COMMON VARS           #
#===============================#

variable "region" {}
variable "stack" {}
variable "environment" {}