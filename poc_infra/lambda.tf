
resource "aws_lambda_function" "poc_writer" {
  function_name = "poc_writer"
  role          = aws_iam_role.poc_lambda_role.arn
  handler       = "poc_writer"
  filename      = "${path.module}/../poc_backend/bin/poc_writer.zip"
  runtime       = "go1.x"
  timeout       = 5
  memory_size   = 256

  source_code_hash = filesha256("${path.module}/../poc_backend/bin/poc_writer.zip")

  environment {
   variables = {
      NEWS_TABLE = aws_dynamodb_table.news_items.name
    }  
  }
}

resource "aws_lambda_permission" "apigw_writer_lambda" {
  statement_id  = "AllowAPIgatewayInvokation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.poc_writer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.poc_api.execution_arn}/*/*/*"
}



resource "aws_lambda_function" "poc_reader" {
  function_name = "poc_reader"
  role          = aws_iam_role.poc_lambda_role.arn
  handler       = "poc_reader"
  filename      = "${path.module}/../poc_backend/bin/poc_reader.zip"
  runtime       = "go1.x"
  timeout       = 5
  memory_size   = 256

  source_code_hash = filesha256("${path.module}/../poc_backend/bin/poc_reader.zip")

  environment {
   variables = {
      NEWS_TABLE = aws_dynamodb_table.news_items.name
    }  
  }
}

resource "aws_lambda_permission" "apigw_reader_lambda" {
  statement_id  = "AllowAPIgatewayInvokation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.poc_reader.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.poc_api.execution_arn}/*/*/*"
}



