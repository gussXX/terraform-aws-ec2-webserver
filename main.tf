// =============== PROVIDER ================
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
// =============== PROVIDER ================