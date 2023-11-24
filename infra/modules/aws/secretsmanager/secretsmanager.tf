resource "aws_secretsmanager_secret" "gmail_api_key" {
  name       = "${var.namespace}-gmail-api-key"
  kms_key_id = data.aws_kms_key.chat_stat_master_kms_key.arn
}

resource "aws_secretsmanager_secret_version" "gmail_api_key" {
  secret_id     = aws_secretsmanager_secret.gmail_api_key.id
  secret_string = var.gmail_api_key
}

resource "aws_secretsmanager_secret" "deployer_creds" {
  name       = "${var.namespace}-${var.environment}-terraform-deployer-creds"
  kms_key_id = var.kms_key_arn_master
}

resource "aws_secretsmanager_secret_version" "deployer_creds" {
  secret_id = aws_secretsmanager_secret.deployer_creds.id
  secret_string = jsonencode(tomap({
    "access_key_id"     = var.terraform_deployer_user,
    "secret_access_key" = var.terraform_deployer_pass
    }
  ))
}

