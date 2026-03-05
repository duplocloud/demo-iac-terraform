resource "aws_iam_role" "dynamodb_app" {
  name = "${var.name_prefix}-dynamodb-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-dynamodb-app-role"
  })
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "${var.name_prefix}-dynamodb-access-policy"
  description = "Policy for backend application to access DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = aws_dynamodb_table.app_data.arn
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:GenerateDataKey"
        ]
        Resource = aws_kms_key.dynamodb.arn
      }
    ]
  })

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-dynamodb-access-policy"
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb_app_attach" {
  role       = aws_iam_role.dynamodb_app.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}
