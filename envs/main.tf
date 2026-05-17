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
Internet Gateway
************************************************************/
module "igw" {
  source = "../modules/internet_gateway"

  vpc_id = module.vpc.id_vpc
}

/************************************************************
Route Table
************************************************************/
module "rtb" {
  source = "../modules/route_table"

  vpc_id     = module.vpc.id_vpc
  subnet_ids = module.subnet.id_subnet
  igw_id     = module.igw.id_igw
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
    module.rtb.id_rtb["public_ec2"],
    module.rtb.id_rtb["private_ec2"]
  ]
  endpoints_subnet_ids = [
    module.subnet.id_subnet["private_endpoints_1a"]
  ]
  endpoints_sg_ids = [
    module.sg.id_sg["endpoints"]
  ]
}

/************************************************************
S3
************************************************************/
module "s3" {
  source = "../modules/s3"

  account_id = local.account_id
  region     = local.region_name
}

/************************************************************
IAM
************************************************************/
module "iam" {
  source = "../modules/iam_role"

  partition = local.partition_name
}

/************************************************************
Key Pair
************************************************************/
module "key_pair" {
  source = "../modules/key_pair"
}

/************************************************************
EC2
************************************************************/
module "private_ec2" {
  source = "../modules/ec2"
  depends_on = [
    module.privatelink
  ]

  ami_id                = data.aws_ami.rhel9.id
  subnet_id             = module.subnet.id_subnet["private_ec2_1a"]
  sg_id                 = module.sg.id_sg["private_ec2"]
  instance_profile_name = module.iam.name_private_ec2_instance_profile
  region                = local.region_name
  keypair_id            = module.key_pair.id_keypair
  host_name             = "private-rhel"
}

module "public_ec2" {
  source = "../modules/ec2"
  depends_on = [
    module.privatelink
  ]

  ami_id                = data.aws_ami.rhel9.id
  subnet_id             = module.subnet.id_subnet["public_ec2_1a"]
  sg_id                 = module.sg.id_sg["public_ec2"]
  instance_profile_name = module.iam.name_public_ec2_instance_profile
  region                = local.region_name
  keypair_id            = module.key_pair.id_keypair
  host_name             = "public-rhel"
}