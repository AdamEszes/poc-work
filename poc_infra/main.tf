terraform {
  required_version = "~> 1.2.7"
  backend "s3" {
    encrypt  = true
  }
}