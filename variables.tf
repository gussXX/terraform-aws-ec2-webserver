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
  description = "Lista de regras de ingress para o SG"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
}
// === INGRESS =============================================

// === SECURITY GROUP ======================================
