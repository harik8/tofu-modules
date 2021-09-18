module "eks" {
  source = "../../modules/eks"

  eks_version             = "1.18"
  endpoint_private_access = true
  endpoint_public_access  = true
  subnet_ids              = data.terraform_remote_state.subnet.outputs.subnet.public_subnet_ids
  vpc_cidr                = data.terraform_remote_state.vpc.outputs.vpc.vpc_cidr
  vpc_id                  = data.terraform_remote_state.vpc.outputs.vpc.vpc

  core_dns_version        = "v1.7.0-eksbuild.1"
  kube_proxy_version      = "v1.18.8-eksbuild.1"
  vpc_cni_version         = "v1.7.5-eksbuild.1"

  environment             = var.environment
  region                  = var.region
  stack                   = var.stack
}

output "vpc" {
 value = module.eks.kubeconfig
}