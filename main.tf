# ======================================================
# IAM Role and Policy for Secrets Manager
# ======================================================

# This IAM role and policy allows the ECS & Lambda task to access
resource "aws_iam_role" "secretsmanager" {
  name = "${var.aws_region}-${var.environment}-secretsmanager-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole",
      }
    ]
  })
}

# This IAM policy allows access to the specific secret in Secrets Manager
resource "aws_iam_policy" "secretsmanager" {
  name        = "${var.aws_region}-${var.environment}-secretsmanager-policy"
  description = "Policy to allow access to specific secret in Secrets Manager"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "kms:Decrypt",
          "kms:DescribeKey"
        ],
        Resource = aws_secretsmanager_secret.secretsmanager.arn
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "secretsmanager" {
  role       = aws_iam_role.secretsmanager.name
  policy_arn = aws_iam_policy.secretsmanager.arn
  depends_on = [ aws_iam_policy.secretsmanager ]
}

# ======================================================
# KMS Key for Secrets Manager
# ======================================================

# This KMS key is used to encrypt the secrets in Secrets Manager
resource "aws_kms_key" "secretsmanager" {
  description = "${var.aws_region}-${var.environment}-secretsmanager-key"
  key_usage   = "ENCRYPT_DECRYPT"
  enable_key_rotation = true
  deletion_window_in_days = 7
  tags = {
    name        = "${var.aws_region}-${var.environment}-kms-key"
  }
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "Enable IAM User Permissions",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action = "kms:*",
        Resource = "*"
      }
    ]
  })
}

# This alias is used to reference the KMS key in Secrets Manager
resource "aws_kms_alias" "secretsmanager" {
  name          = "alias/${var.aws_region}-${var.environment}-secretsmanager"
  target_key_id = aws_kms_key.secretsmanager.key_id
}

# ======================================================
# AWS Secrets Manager Creation
# ======================================================

# This resource creates a secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "secretsmanager" {
  name = "${var.aws_region}-${var.environment}-secretsmanager"
  kms_key_id = aws_kms_alias.secretsmanager.arn
  lifecycle {
    prevent_destroy = false
  }
  depends_on = [ aws_kms_key.secretsmanager, aws_kms_alias.secretsmanager ]
}

# This resource creates a version of the secret in AWS Secrets Manager
resource "aws_secretsmanager_secret_version" "secretsmanager" {
  secret_id = aws_secretsmanager_secret.secretsmanager.id
  secret_string = jsonencode({
    Environment = "var.environment"
  })
  depends_on = [ aws_secretsmanager_secret.secretsmanager ]
}
