output "secretsmanager_name" {
  description = "The name of the Secrets Manager secret."
  value = module.secrets_manager.secret_name
}
