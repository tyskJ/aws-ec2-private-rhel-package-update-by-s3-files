/************************************************************
Bucket - For File Integration
************************************************************/
### Bucket
resource "aws_s3_bucket" "file_integration" {
  bucket              = "file-integration-${var.account_id}-${var.region}-an"
  bucket_namespace    = "account-regional"
  force_destroy       = true
  object_lock_enabled = false
  tags = {
    Name = "file-integration-${var.account_id}-${var.region}-an"
  }
}

### Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "file_integration" {
  bucket                  = aws_s3_bucket.file_integration.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

### Object Ownership
resource "aws_s3_bucket_ownership_controls" "file_integration" {
  bucket = aws_s3_bucket.file_integration.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

### Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "file_integration" {
  bucket = aws_s3_bucket.file_integration.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled       = true
    blocked_encryption_types = ["SSE-C"]
  }
}

/************************************************************
Bucket - For S3 Files
************************************************************/
### Bucket
resource "aws_s3_bucket" "s3_files" {
  bucket              = "s3-files-${var.account_id}-${var.region}-an"
  bucket_namespace    = "account-regional"
  force_destroy       = true
  object_lock_enabled = false
  tags = {
    Name = "s3-files-${var.account_id}-${var.region}-an"
  }
}

### Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "s3_files" {
  bucket                  = aws_s3_bucket.s3_files.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

### Object Ownership
resource "aws_s3_bucket_ownership_controls" "s3_files" {
  bucket = aws_s3_bucket.s3_files.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

### Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_files" {
  bucket = aws_s3_bucket.s3_files.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled       = true
    blocked_encryption_types = ["SSE-C"]
  }
}

### Versioning
resource "aws_s3_bucket_versioning" "s3_files" {
  bucket = aws_s3_bucket.s3_files.id
  versioning_configuration {
    status = "Enabled"
  }
}