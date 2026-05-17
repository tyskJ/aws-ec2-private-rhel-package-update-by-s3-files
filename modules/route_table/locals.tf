locals {
  rtbs = {
    public_ec2 = {
      name = "public-ec2-rtb"
    }
    private_ec2 = {
      name = "private-ec2-rtb"
    }
    eni = {
      name = "private-eni-rtb"
    }
  }
  rtb_assoc = {
    public_ec2_1a = {
      rtb_key = "public_ec2"
    }
    private_ec2_1a = {
      rtb_key = "private_ec2"
    }
    private_mountpoint_1a = {
      rtb_key = "eni"
    }
    private_endpoints_1a = {
      rtb_key = "eni"
    }
  }
}