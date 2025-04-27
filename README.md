# AWS Secrets Manager 
# AWS Key Management Service

* Centrally manage the lifecycle of secrets
* AWS managed service that makes it easy for you to create and control the encryption keys that are used to encrypt your data

## Additional Resources

- [Amazon Secrets Manager User Guide](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)
- [Amazon KMS Key User Guide](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
- [Terraform AWS KMS Module Documentation](https://registry.terraform.io/modules/terraform-aws-modules/kms/aws/latest)
- [Terraform AWS Secrets Manager Module Documentation](https://registry.terraform.io/modules/terraform-aws-modules/secrets-manager/aws/latest)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.96.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | terraform-aws-modules/kms/aws | 3.1.1 |
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | terraform-aws-modules/secrets-manager/aws | 1.3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | A unique identifier for your application, used in provisioning profiles. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where resources will be created (e.g., us-east-1, us-west-2). | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment where resources will be deployed (e.g., dev, staging, prod). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secretsmanager_name"></a> [secretsmanager\_name](#output\_secretsmanager\_name) | The name of the Secrets Manager secret. |
<!-- END_TF_DOCS -->
