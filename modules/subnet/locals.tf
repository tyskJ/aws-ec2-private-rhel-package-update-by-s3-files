locals {
  subnets = {
    private_ec2_1a = {
      name       = "private-subnet-ec2-1a"
      cidr_bits  = 8
      cidr_idnex = 1
      az_index   = 0
      map_public = false
    }
    private_endpoint_1a = {
      name       = "private-subnet-endpoint-1a"
      cidr_bits  = 8
      cidr_idnex = 2
      az_index   = 0
      map_public = false
    }
    private_mountpoint_1a = {
      name       = "private-subnet-mountpoint-1a"
      cidr_bits  = 8
      cidr_idnex = 3
      az_index   = 0
      map_public = false
    }
  }
}