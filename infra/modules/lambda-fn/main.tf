resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  role          = aws_iam_role.lambda_role.arn
  runtime       = var.runtime
  filename      = var.filename

  environment {
    variables = var.environment
  }

  source_code_hash = filebase64sha256(var.filename)

  dynamic "dead_letter_config" {
    for_each = var.dlq_arn != null ? [1] : []
    content {
      target_arn = var.dlq_arn
    }
    
  }
  
}