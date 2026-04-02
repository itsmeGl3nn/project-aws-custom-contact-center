#!/bin/bash
# LocalStack initialization script
# Sets up basic AWS resources for development

set -e

echo "=== LocalStack Initialization Setup ==="

# Wait for LocalStack to be ready
until aws --endpoint-url=http://localhost:4566 dynamodb list-tables; do
  echo "Waiting for LocalStack..."
  sleep 2
done

echo "✓ LocalStack is ready"

# Create DynamoDB table
echo "Creating DynamoDB table..."
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
  --table-name contacts \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --key-schema AttributeName=id,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1 2>/dev/null || echo "Table already exists"

# Create S3 bucket
echo "Creating S3 bucket..."
aws --endpoint-url=http://localhost:4566 s3 mb s3://contact-center-bucket --region us-east-1 2>/dev/null || echo "Bucket already exists"

# Create SQS queue
echo "Creating SQS queue..."
aws --endpoint-url=http://localhost:4566 sqs create-queue \
  --queue-name contact-queue \
  --region us-east-1 2>/dev/null || echo "Queue already exists"

# Create SNS topic
echo "Creating SNS topic..."
aws --endpoint-url=http://localhost:4566 sns create-topic \
  --name contact-topic \
  --region us-east-1 2>/dev/null || echo "Topic already exists"

echo "✓ LocalStack initialization complete!"
