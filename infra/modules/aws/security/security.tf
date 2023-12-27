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
}

resource "aws_security_group" "eks" {
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elasticache" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "eks_to_elasticache" {
  security_group_id        = aws_security_group.elasticache.id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.eks.id
}
