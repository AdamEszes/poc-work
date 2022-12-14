resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(
    { Name = var.dynamodb_table }, var.tags
  )
}