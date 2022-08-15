resource "aws_cloudwatch_log_group" "clg_poc_api_access_logs" {
  name              = "API-Gateway-Access-Logs_${aws_api_gateway_rest_api.poc_api.id}/${var.environment}"
  retention_in_days = 365
}