locals {
  subnets = {
    private_ec2_1a = {
      name       = "private-subnet-ec2-1a"
      az         = "a"
      cidr       = "10.0.1.0/24"
      map_public = false
    }
    private_eni_1a = {
      name       = "private-subnet-eni-1a"
      az         = "a"
      cidr       = "10.0.2.0/24"
      map_public = false
    }
  }
}