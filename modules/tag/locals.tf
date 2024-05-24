locals {
  default_tags = {
    Name         = join("-", [var.workload, var.environment, var.name])
    Description  = var.description
    Environment  = var.environment
    Workload     = var.workload
    Region       = data.aws_region.current.name
    Team         = var.team
    OpenTofu     = true
  }
}