/************************************************************
File System
************************************************************/
resource "aws_s3files_file_system" "this" {
  bucket   = var.filesystem_s3_bucket_arn
  role_arn = var.filesystem_role_arn
  tags = {
    Name = "file-system"
  }
}

/************************************************************
Mount Target
************************************************************/
resource "aws_s3files_mount_target" "this" {
  file_system_id  = aws_s3files_file_system.this.id
  subnet_id       = var.subnet_id
  ip_address_type = "IPV4_ONLY"
  security_groups = var.sg_ids
}