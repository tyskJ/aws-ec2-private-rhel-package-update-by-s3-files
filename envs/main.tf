/************************************************************
VPC
************************************************************/
module "vpc" {
  source = "../modules/vpc"

  vpc_cidr = "10.0.0.0/16"
}

/************************************************************
Subnet
************************************************************/
module "subnet" {
  source = "../modules/subnet"

  vpc_cidr = "10.0.0.0/16"
  vpc_id   = module.vpc.id_vpc
}

/************************************************************
Route Table
************************************************************/
module "rtb" {
  source = "../modules/route_table"

  vpc_id     = module.vpc.id_vpc
  subnet_ids = module.subnet.id_subnet
}

/************************************************************
Security Group
************************************************************/
module "sg" {
  source = "../modules/security_group"

  vpc_id = module.vpc.id_vpc
}

/************************************************************
PrivateLink
************************************************************/
module "privatelink" {
  source = "../modules/privatelink"

  vpc_id = module.vpc.id_vpc
  rtb_ids = [
    module.rtb.id_private_ec2_rtb
  ]
  endpoints_subnet_ids = [
    module.subnet.id_subnet["private_endpoints_1a"]
  ]
  endpoints_sg_ids = [
    module.sg.id_sg["endpoints"]
  ]
}