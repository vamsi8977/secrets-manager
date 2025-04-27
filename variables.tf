# ======================================================
# AWS
# ======================================================

variable "aws_region" {
  description = "The AWS region where resources will be created (e.g., us-east-1, us-west-2)."
  type        = string
}

# ======================================================
# Tags
# ======================================================

variable "app_id" {
  description = "A unique identifier for your application, used in provisioning profiles."
  type        = string
}

variable "environment" {
  description = "The name of the environment where resources will be deployed (e.g., dev, staging, prod)."
  type        = string
}
