/************************************************************
Common
************************************************************/
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

/************************************************************
RHEL 9
************************************************************/
data "aws_ami" "rhel9" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "name"
    values = ["RHEL-9*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp3"]
  }
}