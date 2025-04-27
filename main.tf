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
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "kms:Decrypt",
          "kms:DescribeKey"
        ],
        Resource = module.secrets_manager.secret_arn
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "secretsmanager" {
  role       = aws_iam_role.secretsmanager.name
  policy_arn = aws_iam_policy.secretsmanager.arn
  depends_on = [aws_iam_policy.secretsmanager]
}

# ======================================================
# KMS Key for Secrets Manager
# ======================================================

# This module creates a KMS key for encrypting the secret in Secrets Manager
module "kms" {
  source                  = "terraform-aws-modules/kms/aws"
  version                 = "3.1.1"
  description             = "The KMS key for Secrets Manager."
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  key_administrators      = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  tags = {
    name = "${var.aws_region}-${var.environment}-kms-key"
  }
  aliases = ["alias/${var.aws_region}-${var.environment}-kms-key"]
  aliases_use_name_prefix = true
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "Enable IAM User Permissions",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*",
        Resource = "*"
      }
    ]
  })
}

# ======================================================
# AWS Secrets Manager Creation
# ======================================================

# This resource creates a secret in AWS Secrets Manager
module "secrets_manager" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "1.3.1"
  name    = "${var.aws_region}-${var.environment}-secretsmanager"
  description = "The secret for Secrets Manager."
  recovery_window_in_days = 7
  kms_key_id = module.kms.key_id
  secret_string = jsonencode({
    Environment = var.environment
  })
}
