resource "aws_subnet" "private" {
  count             = local.num_of_zones

  availability_zone = local.zones[count.index]
  cidr_block        = cidrsubnet(var.private_cidr,local.num_of_zones - 1,count.index)
  vpc_id            = var.vpc_id
  
  tags = {
    Name = "${local.default_tag}-private-subnet-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count                    = local.num_of_zones

  availability_zone        = local.zones[count.index]
  cidr_block               = cidrsubnet(var.public_cidr,local.num_of_zones - 1,count.index)
  map_public_ip_on_launch  = var.map_public_ip_on_launch 
  vpc_id                   = var.vpc_id

  tags = {
    Name = "${local.default_tag}-public-subnet-${count.index}"
  }
}

resource "aws_instance" "nat" {
  ami                    = var.nat_instance_ami
  availability_zone      = element(sort(data.aws_availability_zones.available.names), 0)
  instance_type          = var.nat_instance_type
  key_name               = var.key_file
  source_dest_check      = false
  subnet_id              = aws_subnet.public.*.id[0]

  root_block_device {
    delete_on_termination = true
    volume_size           = 8

    tags = {
      Name = "${local.default_tag}-nat-instance"
    }
  }

  tags = {
    Name = "${local.default_tag}-nat-instance"
  } 
}
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat.id
  }

  tags = {
    Name = "${local.default_tag}-nat-instance"
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

tags = {
    Name = "${local.default_tag}-internet-gateway"
  }
}

resource "aws_route_table_association" "private" {
  count          = local.num_of_zones

  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private.*.id[count.index]
}

resource "aws_route_table_association" "public" {
  count          = local.num_of_zones

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.*.id[count.index]
}