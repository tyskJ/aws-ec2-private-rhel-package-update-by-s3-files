output "arn_file_integration_bucket" {
  value = aws_s3_bucket.file_integration.arn
}

output "arn_s3_files_bucket" {
  value = aws_s3_bucket.s3_files.arn
}