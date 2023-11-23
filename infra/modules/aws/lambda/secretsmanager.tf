resource "aws_secretsmanager_secret" "gmail_api_key" {
  name       = "${var.namespace}-gmail-api-key"
  kms_key_id = data.aws_kms_key.chat_stat_master_kms_key.arn
}

resource "aws_secretsmanager_secret_version" "gmail_api_key" {
  secret_id     = aws_secretsmanager_secret.gmail_api_key.id
  secret_string = var.gmail_api_key
}


