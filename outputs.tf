output "secretsmanager_name" {
  value = aws_secretsmanager_secret.secretsmanager.name
  description = "The name of the Secrets Manager secret."
}
