resource "aws_key_pair" "bastion_key" {
  key_name   = "${var.namespace}-${var.environment}-bastion-key"
  public_key = var.fomiller_public_key
}

resource "aws_instance" "bastion" {
  ami                    = "ami-0ed83e7a78a23014e"
  instance_type          = "t4g.nano"
  subnet_id              = var.subnet_ids_public[0]
  vpc_security_group_ids = [var.security_group_id_bastion]
  key_name               = aws_key_pair.bastion_key.key_name

  tags = {
    Name = "${var.namespace}-${var.environment}-bastion"
  }
}
