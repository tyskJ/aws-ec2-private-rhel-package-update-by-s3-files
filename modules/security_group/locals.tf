locals {
  sgs = {
    endpoints = {
      name        = "vpc-interface-endpoints-sg"
      description = "For VPC Interface Endpoints"
    }
    public_ec2 = {
      name        = "public-ec2-sg"
      description = "For Public EC2"
    }
    private_ec2 = {
      name        = "private-ec2-sg"
      description = "For Private EC2"
    }
    s3_files_mounttarget = {
      name        = "s3-files-mounttarget-sg"
      description = "For S3 Files MountTarget"
    }
  }
}