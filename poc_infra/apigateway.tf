resource "aws_api_gateway_rest_api" "poc_api" {
  name        = "${var.naming_prefix}_api"
}

#/news
resource "aws_api_gateway_resource" "news_resource" {
  rest_api_id = aws_api_gateway_rest_api.poc_api.id
  parent_id   = aws_api_gateway_rest_api.poc_api.root_resource_id
  path_part   = "news"
}

resource "aws_api_gateway_method" "news_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.poc_api.id
  resource_id   = aws_api_gateway_resource.news_resource.id
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "news_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.poc_api.id
  resource_id             = aws_api_gateway_resource.news_resource.id
  http_method             = aws_api_gateway_method.news_post_method.http_method
  credentials             = aws_iam_role.poc_api_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.poc_reader.invoke_arn

}

#/newsitem
resource "aws_api_gateway_resource" "newsitem_resource" {
  rest_api_id = aws_api_gateway_rest_api.poc_api.id
  parent_id   = aws_api_gateway_rest_api.poc_api.root_resource_id
  path_part   = "newsitem"
}

resource "aws_api_gateway_method" "newsitem_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.poc_api.id
  resource_id   = aws_api_gateway_resource.newsitem_resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "newsitem_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.poc_api.id
  resource_id             = aws_api_gateway_resource.newsitem_resource.id
  http_method             = aws_api_gateway_method.newsitem_post_method.http_method
  credentials             = aws_iam_role.poc_api_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.poc_writer.invoke_arn

}

#API deployment
resource "aws_api_gateway_deployment" "poc_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.poc_api.id
  stage_name  = ""
  depends_on = [
    aws_api_gateway_integration.newsitem_post_integration,
    aws_api_gateway_integration.news_post_integration
  ]

  variables = {
    deployed_at = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "poc_api_stage" {
  stage_name    = var.environment
  rest_api_id   = aws_api_gateway_rest_api.poc_api.id
  deployment_id = aws_api_gateway_deployment.poc_api_deployment.id
  xray_tracing_enabled = true
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.clg_poc_api_access_logs.arn
    format = jsonencode(
      { 
        "requestId":"$context.requestId",
        "extendedRequestId":"$context.extendedRequestId",
        "ip": "$context.identity.sourceIp",
        "caller":"$context.identity.caller",
        "user":"$context.identity.user",
        "requestTime":"$context.requestTime",
        "httpMethod":"$context.httpMethod",
        "resourcePath":"$context.resourcePath",
        "status":"$context.status",
        "protocol":"$context.protocol",
        "responseLength":"$context.responseLength"
      }
    )
  }
}

resource "aws_api_gateway_api_key" "poc_api_key" {
  name = "${var.naming_prefix}_api_key"
}

// Create API usage plan 
resource "aws_api_gateway_usage_plan" "poc_api_usage_plan" {
  name        = "${var.naming_prefix}_api_usage_plan"

  api_stages {
    api_id = aws_api_gateway_rest_api.poc_api.id
    stage  = aws_api_gateway_stage.poc_api_stage.stage_name
  }

}

// attach API key
resource "aws_api_gateway_usage_plan_key" "poc_api_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.poc_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.poc_api_usage_plan.id
}

output "poc_api_key" {
  sensitive = true
  value = aws_api_gateway_api_key.poc_api_key.value
}