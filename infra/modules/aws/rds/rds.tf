resource "aws_db_instance" "fomiller" {
  allocated_storage      = 22
  max_allocated_storage  = 100
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t4g.micro"
  db_name                = var.namespace
  identifier             = "${var.namespace}-shared-${var.environment}-db"
  username               = var.rds_username
  password               = var.rds_password
  db_subnet_group_name   = var.db_subnet_group_name_private
  vpc_security_group_ids = [var.security_group_id_rds]

  auto_minor_version_upgrade = true
  publicly_accessible        = false
  storage_encrypted          = true
  skip_final_snapshot        = true

  tags = {
    Name = "RDS Postgres Instance"
  }
}
