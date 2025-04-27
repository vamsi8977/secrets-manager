# AWS Secrets Manager

* Centrally manage the lifecycle of secrets

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.crossaccount](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.crossaccount](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.crossaccount](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_secretsmanager_secret.crossaccount](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.crossaccount](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | provide an app-id | `string` | `"0312"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | provide the aws\_region | `string` | `"us-east-1"` | no |
| <a name="input_crossaccount_name"></a> [crossaccount\_name](#input\_crossaccount\_name) | provide the lambda name | `string` | `"crossaccount"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | provide some environment name | `string` | `"develop"` | no |
| <a name="input_mail"></a> [mail](#input\_mail) | provide an email to send mails | `string` | `"vamsikrishnab1992@gmail.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | provide an email to send mails | `string` | `"vamsi"` | no |
| <a name="input_vamsi_account_id"></a> [vamsi\_account\_id](#input\_vamsi\_account\_id) | provide the lambda name | `string` | `"724469731487"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | n/a |
<!-- END_TF_DOCS -->
