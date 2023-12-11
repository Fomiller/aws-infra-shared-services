resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.aws_infra.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name                                     = "public-${element(var.azs, count.index)}"
    "kubernetes.io/role/elb"                 = "1"
    "kubernetes.io/cluster/fomiller-cluster" = "owned"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.aws_infra.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name                                     = "private-${element(var.azs, count.index)}"
    "kubernetes.io/role/internal-elb"        = "1"
    "kubernetes.io/cluster/fomiller-cluster" = "owned"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.aws_infra.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws_infra.id
  }

  tags = {
    Name = "${title(var.namespace)} private route table"
  }
}
