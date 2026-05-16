/************************************************************
VPC Gateway Endpoints
************************************************************/
resource "aws_vpc_endpoint" "gateway_s3" {
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_id            = var.vpc_id
  route_table_ids   = var.rtb_ids
  ip_address_type   = "ipv4"
  dns_options {
    dns_record_ip_type                             = "service-defined"
    private_dns_only_for_inbound_resolver_endpoint = false
  }
  policy = jsonencode({
    Statement = [{
      Action    = "*"
      Effect    = "Allow"
      Principal = "*"
      Resource  = "*"
    }]
    Version = "2008-10-17"
  })
  tags = {
    Name = "gateway-s3"
  }
}