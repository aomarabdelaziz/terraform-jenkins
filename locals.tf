locals {
  env                  = "test"
  region               = "us-east-1"
  zone1                = "us-east-1a"
  zone2                = "us-east-1b"
  eks_name             = "demo"
  eks_version          = "1.33"
  vpc_cider            = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}
