package main

import (
    "context"

    "github.com/aws/aws-lambda-go/events"
    "github.com/aws/aws-lambda-go/lambda"
)

func Handler(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
    if request.HTTPMethod == "POST" {
        return events.APIGatewayProxyResponse{Body: "yepp", StatusCode: 200}, nil
    }

    return events.APIGatewayProxyResponse{Body: "nope", StatusCode: 200}, nil
}

func main() {
    lambda.Start(Handler)
}