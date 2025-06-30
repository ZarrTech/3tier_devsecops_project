module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "3tier-vpc"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true
  map_public_ip_on_launch = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    "Name"                                 = "3tier-public"
    "kubernetes.io/role/elb"               = "1"
   "kubernetes.io/cluster/my-cluster" = "shared" 
  }

  private_subnet_tags = {
    "Name"                                 = "3tier-private"
    "kubernetes.io/role/internal-elb"      = "1"
    "kubernetes.io/cluster/my-cluster" = "shared" 
  }
}


