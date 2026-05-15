/************************************************************
Subnet
************************************************************/
resource "aws_subnet" "this" {
  for_each = local.subnets

  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, each.value.cidr_bits, each.value.cidr_idnex)
  availability_zone       = data.aws_availability_zones.azs.names[each.value.az_index]
  map_public_ip_on_launch = each.value.map_public
  tags = {
    Name = each.value.name
  }
}