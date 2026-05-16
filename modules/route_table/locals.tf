locals {
  rtbs = {
    ec2 = {
      name = "private-ec2-rtb"
    }
    eni = {
      name = "private-eni-rtb"
    }
  }
  rtb_assoc = {
    private_ec2_1a = {
      rtb_key = "ec2"
    }
    private_mountpoint_1a = {
      rtb_key = "eni"
    }
    private_endpoints_1a = {
      rtb_key = "eni"
    }
  }
}