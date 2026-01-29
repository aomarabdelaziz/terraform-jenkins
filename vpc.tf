resource "aws_vpc" "vpc" {
  cidr_block = local.vpc_cider

  enable_dns_support   = local.enable_dns_support
  enable_dns_hostnames = local.enable_dns_support

  tags = {
    Name = "${local.env}-vpc"
  }
}
