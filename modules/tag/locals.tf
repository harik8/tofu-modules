locals {
  default_tags = {
    Name         = join("-", [var.workload, var.utilization])
    Utilization  = var.utilization
    Description  = var.description
    Workload     = var.workload
    Region       = data.aws_region.current.name
    Team         = var.team
    OpenTofu     = true
  }
}