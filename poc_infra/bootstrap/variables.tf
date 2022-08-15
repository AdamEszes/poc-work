variable "bucket" {
  description = "The bucket name for the statefile to create (taken from backend_vars)"
}

variable "dynamodb_table" {
  description = "The DynamoDB lock table to create for the state lock (taken from backend_vars)"
}

variable "key" {
  description = "Not used for bootstrapping, but needs to be declared as this in in the backend_vars"
}

variable "tags" {
  description = "The tags that will be applied to tha statefile bucket and dynamodb lock table"
  default     = {}
}