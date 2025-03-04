provider "aws" {
  region = "us-east-1"
}

# Create S3 bucket for storing training data and models
resource "aws_s3_bucket" "mlops_bucket" {
  bucket = "mlops-churn-prediction-data"
}

# Create an ECR repository for containerized model deployment
resource "aws_ecr_repository" "mlops_repo" {
  name = "mlops-churn-repo"
}

# SageMaker Notebook for experimentation
resource "aws_sagemaker_notebook_instance" "mlops_notebook" {
  name          = "mlops-notebook"
  instance_type = "ml.t3.medium"
  role_arn      = aws_iam_role.sagemaker_role.arn
}

# Lambda function for data preprocessing
resource "aws_lambda_function" "preprocessing_lambda" {
  function_name = "DataPreprocessing"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.8"
  handler       = "preprocessing.lambda_handler"
  filename      = "lambda_function.zip"
}
