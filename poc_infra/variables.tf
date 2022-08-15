variable "naming_prefix" {
  description = "Name prefix for resources"
}

variable "account_id" {
  description = "Account id to be used in resources"
}

variable "environment" {
  description = "Environment to be used in resources"
}

variable "tracing_config_mode" {
  default = "Active"
}

variable "region" {
  description = "Region"
  type = string
  default = "eu-west-1"
}

