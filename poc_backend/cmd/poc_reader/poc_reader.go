package main

import (
	"context"
	"encoding/json"
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"

	"github.com/AdamEszes/poc-work/internal/awsprovider"
	"github.com/AdamEszes/poc-work/internal/config"
	"github.com/AdamEszes/poc-work/internal/model"
)

func Handler(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	tableName := config.NewsTable()

	result := awsprovider.ScanTable(tableName)
	var items []model.NewsItem
	for _, i := range result {
		item := model.NewsItem{}

		err := dynamodbattribute.UnmarshalMap(i, &item)

		if err != nil {
			log.Fatalf("Got error unmarshalling: %s", err)
		}

	}

	responseBody, _ := json.Marshal(items)

	return events.APIGatewayProxyResponse{Body: string(responseBody), StatusCode: 200}, nil
}

func main() {
	lambda.Start(Handler)
}
