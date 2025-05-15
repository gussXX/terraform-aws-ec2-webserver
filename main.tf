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
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("user_data.sh") # Opcional: instalar Apache, etc.

  tags = {
    Name = "TerraformWebServer"
  }
}
// === EC2 INSTANCE ========================================