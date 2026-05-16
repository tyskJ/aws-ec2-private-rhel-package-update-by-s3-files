/************************************************************
Route Table
************************************************************/
resource "aws_route_table" "this" {
  for_each = local.rtbs

  vpc_id = var.vpc_id
  tags = {
    Name = each.value.name
  }
}

/************************************************************
Route Table Association
************************************************************/
resource "aws_route_table_association" "this" {
  for_each = local.rtb_assoc

  route_table_id = aws_route_table.this[each.value.rtb_key].id
  subnet_id      = var.subnet_ids[each.key]
}