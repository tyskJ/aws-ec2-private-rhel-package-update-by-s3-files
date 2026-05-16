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

/************************************************************
IAM
************************************************************/
module "iam" {
  source = "../modules/iam_role"

  partition = local.partition_name
}

/************************************************************
EC2
************************************************************/
module "ec2" {
  source = "../modules/ec2"
  depends_on = [
    module.privatelink
  ]

  subnet_id             = module.subnet.id_subnet["private_ec2_1a"]
  sg_id                 = module.sg.id_sg["ec2"]
  instance_profile_name = module.iam.name_instance_profile
  region                = local.region_name
}