resource "aws_dynamodb_table" "news_items" {
  lifecycle {
    prevent_destroy = false
  }

  name         = "news_items"
  billing_mode = "PAY_PER_REQUEST"

  hash_key     = "date"
  range_key    = "title"

  attribute {
    name = "date"
    type = "S"
  }
  attribute {
    name = "title"
    type = "S"
  }
}

