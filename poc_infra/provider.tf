terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.41, < 4.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}