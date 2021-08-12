module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"
  name    = "${local.name}-vpc"
  cidr    = "172.16.0.0/16"

  azs            = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets = ["172.16.10.0/24", "172.16.11.0/24", "172.16.12.0/24"]
  create_igw           = true
  enable_nat_gateway   = false
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags_as_map

}