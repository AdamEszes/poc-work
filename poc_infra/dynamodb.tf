resource "aws_dynamodb_table" "news_items" {
  lifecycle {
    prevent_destroy = true
  }

  name         = "news_items"
  billing_mode = "PAY_PER_REQUEST"

  hash_key     = "Date"
  range_key    = "Title"

  attribute {
    name = "Date"
    type = "S"
  }
  attribute {
    name = "Title"
    type = "S"
  }
}

