data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "example-use1-test-tfstate"
    key     = "vpc/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}

data "aws_ami" "nat" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-*"]
  }
}