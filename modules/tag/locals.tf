locals {

  environment = var.environment == "" ? terraform.workspace : var.environment

  default_tags = {
    Name        = join("-", [var.workload, local.environment, var.utilization])
    Prefix      = join("-", [var.workload, local.environment])
    CostCenter  = var.costcenter
    Description = var.description
    Environment = local.environment
    Owner       = var.owner
    Utilization = var.utilization
    Workload    = var.workload
    OpenTofu    = true
  }
}