output "aws_region" {
  value = data.aws_region.current.name
}

output "default_tags" {
  value = local.default_tags
}


output "workspace" {
  value = terraform.workspace
}
