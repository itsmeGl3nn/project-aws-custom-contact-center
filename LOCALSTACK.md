# LocalStack Setup Guide

## Prerequisites

- Docker & Docker Compose
- AWS CLI (optional, for manual testing)
- Node.js 18+

## Environment Variables

**Root `.env`** - Shared configuration
- `LOCALSTACK_ENDPOINT`: LocalStack service endpoint
- `AWS_REGION`: AWS region
- `ENVIRONMENT`: dev/prod

**Frontend `.env.local`** - Frontend development config
- `VITE_API_URL`: Backend API endpoint
- `VITE_AWS_ENDPOINT`: LocalStack endpoint for client-side AWS SDK

**Backend `.env`** - Backend development config
- `LOCALSTACK_ENDPOINT`: LocalStack endpoint
- `DynamoDB/SQS/SNS/S3` configuration for LocalStack

## Quick Start

### 1. Start LocalStack and Services

```bash
docker-compose up -d
```

This starts:
- LocalStack on `http://localhost:4566`
- Backend API on `http://localhost:3001`
- Frontend on `http://localhost:5173`

### 2. Verify Setup

```bash
# Check LocalStack status
curl http://localhost:4566/_localstack/health

# Check Backend
curl http://localhost:3001/health

# Frontend
open http://localhost:5173
```

### 3. Manual AWS CLI Testing

```bash
# Set up AWS CLI for LocalStack
export AWS_ENDPOINT_URL_DYNAMODB=http://localhost:4566
export AWS_ENDPOINT_URL_S3=http://localhost:4566
export AWS_ACCESS_KEY_ID=localstack
export AWS_SECRET_ACCESS_KEY=localstack
export AWS_DEFAULT_REGION=us-east-1

# List DynamoDB tables
aws dynamodb list-tables

# List S3 buckets
aws s3 ls

# List SQS queues
aws sqs list-queues
```

## Available AWS Services

The LocalStack setup includes:
- ✅ DynamoDB - NoSQL database
- ✅ S3 - Object storage
- ✅ SQS - Message queue
- ✅ SNS - Pub/Sub messaging
- ✅ Lambda - Serverless functions
- ✅ Cognito - Identity management
- ✅ CloudFormation - IaC
- ✅ IAM - Access management
- ✅ CloudWatch Logs - Logging

## Stopping Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## Troubleshooting

### LocalStack won't start
```bash
docker-compose logs localstack
```

### Backend can't connect to LocalStack
Check that `LOCALSTACK_ENDPOINT=http://localstack:4566` in backend `.env`

### Port conflicts
Change ports in `docker-compose.yml` if 4566, 3001, or 5173 are in use

### Reset everything
```bash
docker-compose down -v
docker system prune -f
docker-compose up -d
```

## Development Workflow

1. Make code changes
2. Services auto-reload if configured with volume mounts
3. Use `docker-compose logs [service]` to debug
4. Test API using curl, Postman, or frontend UI
5. Check data in LocalStack using AWS CLI

## Next Steps

- [ ] Create SAM template for Lambda functions
- [ ] Update backend to use LocalStack endpoints
- [ ] Add data initialization scripts
- [ ] Set up automated testing with LocalStack
