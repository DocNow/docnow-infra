# data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  cluster_name = "umd-mith-demo"
  region       = "us-east-2"

  worker_groups = [
    {
      instance_type        = "t3.small" # 2CPU, 2GB RAM.
      asg_desired_capacity = "3"        # Desired worker capacity in the autoscaling group.
      asg_max_size         = "5"        # Maximum worker capacity in the autoscaling group.
      asg_min_size         = "3"        # Minimum worker capacity in the autoscaling group.
      autoscaling_enabled  = true       # Sets whether policy and matching tags will be added to allow autoscaling.
      # spot_price           = ""        # "0.01" or any value to use "spot" (cheap but can leave) instances
    },
  ]

  tags = {
    Environment   = "POC"
    Creators      = "Docnow"
    creation-date = "${timestamp()}"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.9.0"
  name    = "umd-mith-demo-vpc"
  cidr    = "10.0.0.0/16"
  # azs                = ["${local.region}a", "${local.region}b", "${local.region}c"]
  azs                = ["${data.aws_availability_zones.available.names[0]}", "${data.aws_availability_zones.available.names[1]}", "${data.aws_availability_zones.available.names[2]}"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.4.0/24", "10.0.5.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  tags               = "${merge(local.tags, map("kubernetes.io/cluster/${local.cluster_name}", "shared"))}"
}

module "eks" {
  source                      = "terraform-aws-modules/eks/aws"
  version                     = "5.1.0"
  cluster_name                = local.cluster_name
  subnets                     = module.vpc.private_subnets
  tags                        = local.tags
  vpc_id                      = module.vpc.vpc_id
  worker_groups               = local.worker_groups
  worker_sg_ingress_from_port = "0" # default 1025, which means no POD port exposed below 1024
}
