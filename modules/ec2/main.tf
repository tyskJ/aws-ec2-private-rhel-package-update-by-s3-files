/************************************************************
EC2
************************************************************/
resource "aws_instance" "this" {
  ami           = var.ami_id
  key_name      = var.keypair_id
  instance_type = "m8i-flex.xlarge"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [
    var.sg_id
  ]
  ebs_optimized = true
  root_block_device {
    volume_size           = 100
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
    encrypted             = true
    tags = {
      Name = "${var.host_name}-ec2-root-volume"
    }
  }
  metadata_options {
    http_tokens = "required"
  }
  maintenance_options {
    auto_recovery = "default"
  }
  disable_api_stop        = false
  disable_api_termination = false
  force_destroy           = true
  iam_instance_profile    = var.instance_profile_name
  user_data_base64 = base64gzip(
    templatefile("${path.module}/userdata/linux_init.sh", {
      hostname    = var.host_name
      region_name = var.region
    })
  )
  tags = {
    Name = var.host_name
  }
  # userdataを変更すると再起動が走るため抑止
  # 代わりに、user_data_replace_on_change は効かなくなる
  lifecycle {
    ignore_changes = [
      ami,
      user_data_base64
    ]
  }
}