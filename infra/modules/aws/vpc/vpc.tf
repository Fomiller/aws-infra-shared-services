resource "aws_vpc" "aws_infra" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.namespace}-vpc"
  }
}
