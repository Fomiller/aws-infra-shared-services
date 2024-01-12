resource "aws_internet_gateway" "aws_infra" {
  vpc_id = aws_vpc.aws_infra.id
  tags = {
    Name = "Fomiller VPC IG"
  }
}
