# removing nat gateway due to cost. leaving configuration here if its ever needed

# resource "aws_nat_gateway" "aws_infra" {
#   allocation_id = aws_eip.aws_infra.id
#   subnet_id     = aws_subnet.public[0].id
#
#   depends_on = [aws_internet_gateway.aws_infra]
# }

# this should only cost $4 a month vs $30 a month
module "fck-nat" {
  source = "git::https://github.com/RaJiska/terraform-aws-fck-nat.git?ref=main"
  # source = "RaJiska/fck-nat/aws"
  # version = "v1.2.0"

  name          = "${var.namespace}-my-fck-nat"
  vpc_id        = aws_vpc.aws_infra.id
  subnet_id     = aws_subnet.public[0].id
  instance_type = "t4g.nano"
  # ha_mode              = true                 # Enables high-availability mode
  # eip_allocation_ids   = ["eipalloc-abc1234"] # Allocation ID of an existing EIP
  use_cloudwatch_agent = true # Enables Cloudwatch agent and have metrics reported

  update_route_tables = true
  route_tables_ids = {
    "${title(var.namespace)} private route table" = aws_route_table.private.id
  }
}
