resource "aws_eks_cluster" "self" {
  name     = "${local.default_tag}-eks"
  role_arn = aws_iam_role.master.arn
  version  = var.eks_version

  vpc_config { 
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    subnet_ids              = flatten([var.subnet_ids])
    # security_group_ids      = [aws_security_group.self.id]  
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  ]
}

resource "aws_iam_role" "master" {
  name = "${local.default_tag}-eks-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["eks.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.master.name
}

resource "aws_iam_openid_connect_provider" "self" {
  depends_on      = [aws_eks_cluster.self]

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.self.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.self.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "oidc" {
  assume_role_policy = data.aws_iam_policy_document.oidc.json
  name               = "${local.default_tag}-oidc-role"
}

resource "aws_security_group" "self" {
  name        = "${local.default_tag}-eks-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.default_tag}-eks-sg",
    "kubernetes.io/cluster/example-use2-test-eks" = "owned"
  }
}

# resource "aws_eks_addon" "coredns" {
#   addon_name               = "coredns"
#   addon_version            = var.core_dns_version
#   cluster_name             = aws_eks_cluster.self.name
#   resolve_conflicts        = "OVERWRITE"
# }

resource "aws_eks_addon" "kube-proxy" {
  addon_name        = "kube-proxy"
  addon_version     = var.kube_proxy_version
  cluster_name      = aws_eks_cluster.self.name
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "vpc_cni" {
  addon_name                = "vpc-cni"
  addon_version             = var.vpc_cni_version
  cluster_name              = aws_eks_cluster.self.name
  resolve_conflicts         = "OVERWRITE"
  service_account_role_arn  = aws_iam_role.oidc.arn
}

# resource "aws_iam_openid_connect_provider" "oidc_provider" {
  

#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.self.certificates[0].sha1_fingerprint]
#   url             = aws_eks_cluster.self.identity[0].oidc[0].issuer
# }