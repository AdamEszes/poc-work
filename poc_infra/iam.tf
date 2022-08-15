
resource "aws_iam_role" "poc_lambda_role" {
  name = "${var.naming_prefix}_poc_lambda_role"

  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
              "Service": [
                "lambda.amazonaws.com"
                ]
          },
          "Action": "sts:AssumeRole"
        }
    ]
}
EOF

}

resource "aws_iam_role_policy" "poc_lambda_role_policy" {
  name = "${var.naming_prefix}_poc_lambda_role_policy"
  role = aws_iam_role.poc_lambda_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
           ],
           "Resource": "arn:aws:logs:*:*:*",
           "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface"          
            ],
            "Resource": [
              "*"
            ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:BatchGet*",
            "dynamodb:DescribeStream",
            "dynamodb:DescribeTable",
            "dynamodb:Get*",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:BatchWrite*",
            "dynamodb:CreateTable",
            "dynamodb:Delete*",
            "dynamodb:Update*",
            "dynamodb:PutItem"
          ],
          "Resource" : [
            "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.news_items.name}",
            "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.news_items.name}/index/*"
          ]
        }
    ]
  }
EOF
}

resource "aws_iam_role" "poc_api_role" {
  name               = "${var.naming_prefix}_poc_api_role"
  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
            "Service": [
              "apigateway.amazonaws.com"
              ]
        },
        "Action": "sts:AssumeRole"
      }
    ]
}
EOF

}

resource "aws_iam_role_policy" "poc_api_role_policy" {
  name   = "${var.naming_prefix}_poc_api_role_policy"
  role   = aws_iam_role.poc_api_role.id
  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [ "lambda:InvokeFunction" ],
      "Effect": "Allow",
      "Resource": [
          "*"
      ]
    }
  ]
}
EOF
}

