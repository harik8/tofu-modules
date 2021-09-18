resource "aws_network_acl" "self" {
  vpc_id = var.vpc_id

  subnet_ids = flatten([
    aws_subnet.public.*.id,
    aws_subnet.private.*.id,
  ])

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${local.default_tag}-nacl"
  }
}