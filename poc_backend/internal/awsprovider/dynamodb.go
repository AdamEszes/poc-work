package awsprovider

import (
	"log"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"
)

func Session() *session.Session {
	return session.Must(session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	}))
}

func ScanTable(tableName string) (result []map[string]*dynamodb.AttributeValue) {
	sess := Session()
	svc := dynamodb.New(sess)

	scanInput := &dynamodb.ScanInput{
		TableName: aws.String(tableName),
	}

	svc.ScanPages(scanInput,
		func(page *dynamodb.ScanOutput, lastPage bool) bool {
			result = append(result, page.Items...)
			return !lastPage
		})

	return result
}

func PutItem(item interface{}, tableName string) error {
	session := Session()
	svc := dynamodb.New(session)

	av, err := dynamodbattribute.MarshalMap(item)
	if err != nil {
		log.Fatalf("Error marshalling item")
		return err
	}

	input := &dynamodb.PutItemInput{
		Item:      av,
		TableName: aws.String(tableName),
	}

	_, err = svc.PutItem(input)
	if err != nil {
		log.Fatalf("Error putting item")
		return err
	}

	return nil
}
