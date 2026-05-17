/************************************************************
Security Group
************************************************************/
resource "aws_security_group" "this" {
  for_each = local.sgs

  vpc_id      = var.vpc_id
  name        = each.value.name
  description = each.value.description
  tags = {
    Name = each.value.name
  }
}

/************************************************************
Security Group Rule
************************************************************/
### Ingress
resource "aws_security_group_rule" "endpoints_sg_ingress_https_from_public_ec2_sg" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.this["public_ec2"].id
  security_group_id        = aws_security_group.this["endpoints"].id
  description              = "From Public EC2 SG HTTPS"
}
resource "aws_security_group_rule" "endpoints_sg_ingress_https_from_private_ec2_sg" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.this["private_ec2"].id
  security_group_id        = aws_security_group.this["endpoints"].id
  description              = "From Private EC2 SG HTTPS"
}

### Egress
resource "aws_security_group_rule" "public_ec2_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this["public_ec2"].id
  description       = "To Unrestricted Traffic"
}
resource "aws_security_group_rule" "private_ec2_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this["private_ec2"].id
  description       = "To Unrestricted Traffic"
}