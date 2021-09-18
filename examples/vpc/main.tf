module "vpc" {
  source = "../../modules/vpc"

  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = var.instance_tenancy

  environment          = var.environment
  region               = var.region
  stack                = var.stack
}

output "vpc" {
 value = module.vpc.vpc_id
}
