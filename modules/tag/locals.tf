locals {
  base_name = join("-", [var.workload, local.region_short_codes[local.region], var.environment, var.utilization])

  name = var.postfix == "" ? local.base_name : join("-", [local.base_name, var.postfix])

  environment = var.environment == "" ? terraform.workspace : var.environment 

  region = data.aws_region.current.name

  region_short_codes = {
    "eu-north-1" = "eun1",
  }

  default_tags = {
    Name        = join("-", [var.workload, local.region_short_codes[local.region], local.environment, var.utilization])
    Prefix      = join("-", [var.workload, local.region_short_codes[local.region], local.environment])
    CostCenter  = var.costcenter
    Description = var.description
    Environment = local.environment
    Region      = local.region
    Owner       = var.owner
    Postfix     = var.postfix
    Utilization = var.utilization
    Workload    = var.workload
    OpenTofu    = true
  }
}