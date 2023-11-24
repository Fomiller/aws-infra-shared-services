resource "aws_kms_key" "master" {
  description             = "Fomiller master kms key"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "master" {
  name          = "alias/${var.namespace}-master"
  target_key_id = aws_kms_key.master.key_id
}
