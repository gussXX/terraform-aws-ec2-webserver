// === EC2 INSTANCE ========================================
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
// === EC2 INSTANCE ========================================

// === SECURITY GROUP ======================================
variable "vpc_id" {
  type = string
}
// === INGRESS =============================================
variable "ingress_rules" {
  description = "Regras de ingress para o SG"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
}
// === INGRESS =============================================

// === EGRESS ==============================================
variable "egress_rules" {
  description = "Lista de regras de egress para o SG"
  type = map(object({
    ip_protocol = string
    from_port   = number
    to_port     = number
    cidr_ipv4   = string
    description = string
  }))
}
// === EGRESS ==============================================

// === SECURITY GROUP ======================================
