resource "aws_security_group" "aws_infra_lb" {
  name   = "${var.namespace}-alb-security-group"
  vpc_id = aws_vpc.aws_infra.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "aws_infra_ecs_task" {
#   name   = "${var.namespace}-task-security-group"
#   vpc_id = aws_vpc.aws_infra.id
#
#   # only allow inbound traffic from port 3000 to port 3000
#   ingress {
#     protocol        = "tcp"
#     from_port       = 3000
#     to_port         = 3000
#     security_groups = [aws_security_group.aws_infra_lb.id]
#   }
#
#   # allow all outbound traffic
#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
