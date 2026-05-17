output "name_private_ec2_instance_profile" {
  value = aws_iam_instance_profile.private_ec2.name
}

output "name_public_ec2_instance_profile" {
  value = aws_iam_instance_profile.public_ec2.name
}