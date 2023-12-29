resource "aws_internet_gateway" "aws_infra" {
  vpc_id = aws_vpc.aws_infra.id
  tags = {
    Name = "Fomiller VPC IG"
  }
}

resource "aws_nat_gateway" "aws_infra" {
  allocation_id = aws_eip.aws_infra.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.aws_infra]
}
