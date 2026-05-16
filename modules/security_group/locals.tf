locals {
  sgs = {
    endpoints = {
      name        = "vpc-interface-endpoints-sg"
      description = "For VPC Interface Endpoints"
    }
    ec2 = {
      name        = "ec2-sg"
      description = "For EC2"
    }
  }
}