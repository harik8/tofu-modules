module "subnet" {
  source = "../../modules/subnet"
    
  igw_id                  = data.terraform_remote_state.vpc.outputs.vpc.internet_gateway
  key_file                = var.key_file
  map_public_ip_on_launch = var.map_public_ip_on_launch
  nat_instance_ami        = data.aws_ami.nat.image_id
  nat_instance_type       = var.nat_instance_type
  private_cidr            = var.private_cidr
  public_cidr             = var.public_cidr
  vpc_id                  = data.terraform_remote_state.vpc.outputs.vpc.vpc

  environment             = var.environment
  region                  = var.region
  stack                   = var.stack
}

output "subnet" {
 value = module.subnet 
}