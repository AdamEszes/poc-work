package main

import (
	"context"
	"encoding/json"

	"github.com/AdamEszes/poc-work/internal/awsprovider"
	"github.com/AdamEszes/poc-work/internal/config"
	"github.com/AdamEszes/poc-work/internal/model"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func Handler(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	var item model.NewsItem
	err := json.Unmarshal([]byte(request.Body), item)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: 400}, err
	}
	err = awsprovider.PutItem(item, config.NewsTable())
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: 500}, err
	}
	return events.APIGatewayProxyResponse{StatusCode: 201}, nil
}

func main() {
	lambda.Start(Handler)
}
