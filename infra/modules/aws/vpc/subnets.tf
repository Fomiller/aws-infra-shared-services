resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.aws_infra.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name                                     = "public-${element(var.azs, count.index)}"
    "kubernetes.io/role/elb"                 = "1"
    "kubernetes.io/cluster/fomiller-cluster" = "owned"
    "karpenter.sh/discovery"                 = "${var.namespace}-cluster"
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
    # "karpenter.sh/discovery"                 = "${var.namespace}-cluster"
  }
}
