resource "aws_security_group" "vpc_public_ingress" {
  name        = "${var.namespace} VPC Public Ingress SG"
  description = "Allow incoming HTTP and HTTPS traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from all sources
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from all sources
  }

  tags = {
    Name = "${var.namespace}-${var.environment}-vpc-public-ingress-sg"
  }
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group" "rds_db_sg" {
  name        = "db-sg"
  description = "Allow internal traffic to RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-${var.environment}-rds-sg"
  }
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group" "bastion_sg" {
  name        = "${var.namespace}-${var.environment}-bastion-sg"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-${var.environment}-bastion-sg"
  }
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group" "eks" {
  name   = "${var.namespace}-eks-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.namespace}-${var.environment}-eks-sg"
  }
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group" "elasticache" {
  name   = "${var.namespace}-elasticache-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.namespace}-${var.environment}-elasticache-sg"
  }
  lifecycle { create_before_destroy = true }
}

