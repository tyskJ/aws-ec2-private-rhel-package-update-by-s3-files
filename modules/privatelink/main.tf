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

/************************************************************
VPC Interface Endpoints
************************************************************/
resource "aws_vpc_endpoint" "interface_ssm" {
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_id              = var.vpc_id
  private_dns_enabled = true
  dns_options {
    dns_record_ip_type                             = "ipv4"
    private_dns_only_for_inbound_resolver_endpoint = false
  }
  subnet_ids         = var.endpoints_subnet_ids
  ip_address_type    = "ipv4"
  security_group_ids = var.endpoints_sg_ids
  policy = jsonencode({
    Statement = [{
      Action    = "*"
      Effect    = "Allow"
      Principal = "*"
      Resource  = "*"
    }]
  })
  tags = {
    Name = "interface-ssm"
  }
}

resource "aws_vpc_endpoint" "interface_ssmmessages" {
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_id              = var.vpc_id
  private_dns_enabled = true
  dns_options {
    dns_record_ip_type                             = "ipv4"
    private_dns_only_for_inbound_resolver_endpoint = false
  }
  subnet_ids         = var.endpoints_subnet_ids
  ip_address_type    = "ipv4"
  security_group_ids = var.endpoints_sg_ids
  policy = jsonencode({
    Statement = [{
      Action    = "*"
      Effect    = "Allow"
      Principal = "*"
      Resource  = "*"
    }]
  })
  tags = {
    Name = "interface-ssmmessages"
  }
}