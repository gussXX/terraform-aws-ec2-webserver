// === PROVIDER ============================================
terraform {
    backend "local" {
    path = "/state/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }
}
// === PROVIDER ============================================

// === EC2 INSTANCE ========================================
resource "aws_instance" "instance_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.security_group_configs.id]

  user_data = file("./files/user_data.sh") # Opcional: instalar Apache, etc.

  tags = {
    Name = "Terraform-WebServer"
  }
}
// === EC2 INSTANCE ========================================

// === SECURITY GROUP ======================================
resource "aws_security_group" "security_group_configs" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

// === INGRESS =============================================
resource "aws_vpc_security_group_ingress_rule" "ingress" {

  for_each = {
    for idx, rule in var.ingress_rules :
    "${idx}" => rule
  }

  security_group_id = aws_security_group.security_group_configs.id

  cidr_ipv4   = each.value.cidr_blocks
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}
// === INGRESS =============================================
// === EGRESS ==============================================
resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.security_group_configs.id

  cidr_ipv4   = "10.0.0.0/8"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 0
}
// === EGRESS ==============================================
// === SECURITY GROUP ======================================