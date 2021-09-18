output "kubernetes_endpoint" {
  value = aws_eks_cluster.self.endpoint
}

output "kubernetes_certificate_data" {
  value = aws_eks_cluster.self.certificate_authority[0].data
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}