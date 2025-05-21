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

// === VPC =================================================
// === VPC =================================================

// === EC2 INSTANCE ========================================
resource "aws_instance" "instance_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.security_group_configs.id]

  user_data = file("./files/user_data.sh")

  tags = {
    Name = "Terraform-WebServer"
  }
}
// === EC2 INSTANCE ========================================

// === SECURITY GROUP ======================================
resource "aws_security_group" "security_group_configs" {

 revoke_rules_on_delete = true

  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

// === INGRESS =============================================
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  
  for_each = var.ingress_rules
  security_group_id = aws_security_group.security_group_configs.id

  cidr_ipv4   = each.value.cidr_blocks
  from_port   = each.value.from_port
  ip_protocol = each.value.protocol
  to_port     = each.value.to_port
}
// === INGRESS =============================================

// === EGRESS ==============================================
resource "aws_vpc_security_group_egress_rule" "egress" {

  for_each = var.egress_rules
  security_group_id = aws_security_group.security_group_configs.id
  
  ip_protocol = each.value.ip_protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  cidr_ipv4   = each.value.cidr_ipv4
}
// === EGRESS ==============================================

// === SECURITY GROUP ======================================