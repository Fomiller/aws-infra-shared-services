resource "aws_timestreamwrite_database" "example" {
  database_name = var.namespace
  kms_key_id    = var.kms_key_arn_master
}
