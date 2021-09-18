# resource "aws_eks_node_group" "default" {
#   ami_type        = "AL2_x86_64"
#   capacity_type   = "SPOT"
#   cluster_name    = aws_eks_cluster.self.name
#   disk_size       = "8"
#   instance_types  = ["t2.micro"]
#   node_group_name = "${local.default_tag}-default-node-group"
#   version         = "1.18"
#   node_role_arn   = aws_iam_role.node.arn
#   subnet_ids      = flatten([var.subnet_ids])

#   scaling_config {
#     desired_size = 2
#     max_size     = 3
#     min_size     = 2
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.node,
#     aws_iam_role_policy_attachment.registry,
#   ]
# }

resource "aws_iam_role" "node" {
  name = "${local.default_tag}-node"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

resource "aws_iam_instance_profile" "node" {
  name = "${local.default_tag}-instance-profile"
  role = "${aws_iam_role.node.name}"
}

resource "aws_launch_configuration" "node" {
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.node.name
  image_id                    = data.aws_ami.eks-worker.id
  instance_type               = "t2.micro"
  spot_price                  = "0.0035"
  name_prefix                 = "${local.default_tag}-launch-configuration"
  security_groups             = ["${aws_security_group.self.id}"]
  user_data_base64            = "${base64encode(local.userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "node" {
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.node.id
  max_size             = 2
  min_size             = 1
  name                 = "${local.default_tag}-asg"
  vpc_zone_identifier  = flatten([var.subnet_ids])

  tag {
    key                 = "Name"
    value               = "${local.default_tag}-worker-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${aws_eks_cluster.self.name}"
    value               = "owned"
    propagate_at_launch = true
  }
}