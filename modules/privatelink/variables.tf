variable "vpc_id" {
  type = string
}

variable "rtb_ids" {
  type = list(string)
}

variable "endpoints_subnet_ids" {
  type = list(string)
}

variable "endpoints_sg_ids" {
  type = list(string)
}