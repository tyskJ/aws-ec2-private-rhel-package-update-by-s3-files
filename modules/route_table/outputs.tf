output "id_private_ec2_rtb" {
  value = aws_route_table.this["ec2"].id
}