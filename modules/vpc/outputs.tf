output "internet_gateway" {
  value = aws_internet_gateway.self.id
}

output "vpc_cidr" {
  value = aws_vpc.self.cidr_block
}

output "vpc" {
  value = aws_vpc.self.id
}