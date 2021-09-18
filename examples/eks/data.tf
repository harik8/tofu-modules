data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "example-use1-test-tfstate"
    key     = "vpc/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}

data "terraform_remote_state" "subnet" {
  backend = "s3"

  config = {
    bucket  = "example-use1-test-tfstate"
    key     = "subnet/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}