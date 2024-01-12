resource "aws_nat_gateway" "aws_infra" {
  allocation_id = aws_eip.aws_infra.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.aws_infra]
}
