variable "filesystem_s3_bucket_arn" {
  type = string
}

variable "filesystem_role_arn" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}