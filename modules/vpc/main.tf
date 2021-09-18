resource "aws_vpc" "self" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support 
  instance_tenancy     = var.instance_tenancy
  
  tags = {
    Name = "${local.default_tag}-vpc"
  }
}

resource "aws_internet_gateway" "self" {
  depends_on = [aws_vpc.self]
  
  vpc_id = aws_vpc.self.id
  
  tags = {
    Name = "${local.default_tag}-igw"
  }
}



