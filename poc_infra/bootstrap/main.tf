provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = "~> 1.2.7" // keep to this as Jenkins is pinned to 0.12.25 for now
}